class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :title
      t.integer :creator_id

      t.timestamps
    end
    
    add_index :stories, :title
    add_index :stories, :creator_id
  end
end
