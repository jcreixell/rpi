#
# Update packages from CRAN
#

require "dcf"

CRAN_HOST = 'cran.r-project.org'
CRAN_PACKAGES_PATH = '/src/contrib/'
TMP_PATH = "#{Rails.root}/tmp/"

def get_package_index
  remote_path = CRAN_PACKAGES_PATH + 'PACKAGES.gz'
  local_path = TMP_PATH + 'PACKAGES.gz'

  Net::HTTP.start(CRAN_HOST) do |http|
    resp = http.get(remote_path)
    open(local_path, "wb") { |file| file.write(resp.body) }
  end

  Zlib::GzipReader.open(local_path) do |gz|
    Dcf.parse(gz.read)
  end
end

def get_package_description(package_name, package_version)
  logger.warn("Error reading package: #{package_name} #{package_version}") and return if package_name.blank? || package_version.blank?

  package_filename = "#{package_name}_#{package_version}.tar.gz"
  remote_path = CRAN_PACKAGES_PATH + package_filename
  local_path = "#{TMP_PATH}#{package_filename}"

  Net::HTTP.start(CRAN_HOST) do |http|
    resp = http.get(remote_path)
    open(local_path, "wb") { |file| file.write(resp.body) }
  end

  sh "tar xzf #{local_path} -C #{TMP_PATH}"

  description_file_path = "#{TMP_PATH}/#{package_name}/DESCRIPTION"
  File.open(description_file_path) do |file|
    Dcf.parse file.read
  end
end


namespace :packages do
  desc "Update packages from CRAN"
  task :update => :environment do |args|
    Rake::Task["tmp:clear"].invoke

    packages = get_package_index
    packages.each do |package_info|
      begin
        next if Package.find_by_name_and_version(package_info['Package'], package_info['Version'])

        package_description = get_package_description(package_info['Package'], package_info['Version']).first

        package = Package.create(
          name: package_info['Package'],
          version: package_info['Version'],
          r_version: nil,
          dependencies: package_info['Depends'],
          suggestions: package_info['Suggests'],
          published_at: DateTime.parse(package_description['Date/Publication']),
          title: package_description['Title'],
          description: package_description['Description'],
          license: package_info['License']
        )

        authors = package_description['Author'].split(', ')
        authors.each do |author|
          package.authors << Contributor.find_or_create_by_name(author)
        end

        maintainers = package_description['Maintainer'].split(', ')
        maintainers.each do |maintainer|
          name = maintainer.scan(/<(.*?)>/).flatten
          email = maintainer.scan(/"(.*?)"/).flatten
          package.maintainers << Contributor.find_or_create_by_name(name) do |maintainer_record|
            maintainer_record.email = email
          end
        end

        puts("Added package #{package.name}")
      rescue StandardError => e
        puts "Error while processing #{package_info['Package']} #{package_info['Version']}"
      end
    end
  end
end
