class CreateMaintenances < ActiveRecord::Migration
  def change
    create_table :maintenances do |t|
      t.belongs_to :package
      t.belongs_to :contributor
      t.timestamps
    end

    add_index :maintenances, [:package_id, :contributor_id], :unique => true
  end
end
