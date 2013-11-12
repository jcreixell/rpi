class Contributor < ActiveRecord::Base
  attr_accessible :email, :name

  validates_uniqueness_of :name

  has_many :maintenances
  has_many :authorships
  has_many :authored_packages, :through => :authorships, :source => :package
  has_many :maintained_packages, :through => :maintenances, :source => :package

end
