class Package < ActiveRecord::Base
  attr_accessible :dependencies, :description, :license, :name, :published_at, :r_version, :suggestions, :title, :version

  has_many :authorships
  has_many :maintenances
  has_many :authors, :through => :authorships, :source => :contributor
  has_many :maintainers, :through => :maintenances, :source => :contributor

end
