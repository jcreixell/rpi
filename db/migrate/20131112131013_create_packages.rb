class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.string :name
      t.string :version
      t.string :r_version
      t.string :dependencies
      t.text :suggestions
      t.datetime :published_at
      t.string :title
      t.text :description
      t.string :license

      t.timestamps
    end

    add_index :packages, [:name, :version], :unique => true

  end
end
