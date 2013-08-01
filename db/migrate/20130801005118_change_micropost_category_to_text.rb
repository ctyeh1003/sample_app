class ChangeMicropostCategoryToText < ActiveRecord::Migration
  def change
  	rename_column :microposts, :category, :category_old
  	add_column :microposts, :category, :text

  	Micropost.reset_column_information
  	Micropost.find_each { |c| c.update_attribute(:category, c.category_old) } 
  	remove_column :microposts, :category_old
  end

  def self.down
  end
end
