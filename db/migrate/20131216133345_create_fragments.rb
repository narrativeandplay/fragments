class CreateFragments < ActiveRecord::Migration
  def change
    create_table :fragments do |t|
      t.text :content
      t.integer :author_id
      t.integer :story_id
      t.text :ancestry

      t.timestamps
    end
    
    add_index :fragments, :author_id
    add_index :fragments, :story_id
  end
end
