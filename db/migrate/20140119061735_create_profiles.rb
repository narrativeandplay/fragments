class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.string :pen_name
      t.text :description

      t.timestamps
    end
  end
end
