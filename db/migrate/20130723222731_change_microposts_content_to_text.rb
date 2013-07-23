class ChangeMicropostsContentToText < ActiveRecord::Migration
  def change
  	rename_column :microposts, :content, :content_old
  	add_column :microposts, :content, :text

  	Micropost.reset_column_information
  	Micropost.find_each { |c| c.update_attribute(:content, c.content_old) } 
  	remove_column :microposts, :content_old
  end

  def self.down
  end
end
