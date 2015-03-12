class CreateFacts < ActiveRecord::Migration
  def change
    create_table :facts do |t|
      t.string :text
      t.references :fragment, index: true

      t.timestamps null: false
    end
    add_foreign_key :facts, :fragments
  end
end
