class Authorship < ActiveRecord::Base

  belongs_to :package
  belongs_to :contributor

end
