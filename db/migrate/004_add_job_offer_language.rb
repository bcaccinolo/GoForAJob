class AddJobOfferLanguage < ActiveRecord::Migration
  def self.up
    add_column :jobs, :language, :string
  end

  def self.down
    remove_column :jobs, :language
  end
end
