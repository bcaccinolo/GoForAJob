class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.column :name, :string
      t.timestamps
    end
    
    Category.create :name => "Development" 
    Category.create :name => "Design" 
    Category.create :name => "Business/Exec" 
    Category.create :name => "Miscellaneous" 
        
  end

  
  def self.down
    drop_table :categories
  end
end
