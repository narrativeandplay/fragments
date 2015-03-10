class AddIntensityToFragments < ActiveRecord::Migration
  def change
    add_column :fragments, :intensity, :integer
  end
end
