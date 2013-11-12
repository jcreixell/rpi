class CreateAuthorships < ActiveRecord::Migration
  def change
    create_table :authorships do |t|
      t.belongs_to :package
      t.belongs_to :contributor
      t.timestamps
    end

    add_index :authorships, [:package_id, :contributor_id], :unique => true
  end
end
