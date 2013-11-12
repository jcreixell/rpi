require 'spec_helper'

describe Contributor do

  describe "attributes" do
    describe "auth_token" do
      it { should have_db_column(:name).of_type(:string) }
      it { should have_db_column(:emails).of_type(:string) }
    end
  end

  describe "associations" do
    describe "maintenances" do
      it { should have_many(:maintenances) }
    end
  end
end
