class CreateJobs < ActiveRecord::Migration
  def self.up
    create_table :jobs do |t|
      t.column :company, :string
      t.column :url, :string
      t.column :title, :string
      t.column :location, :string
      t.column :category_id, :integer
      t.column :description, :text
      t.column :instructions, :string
      t.timestamps
    end
  end
  

  def self.down
    drop_table :jobs
  end
end
