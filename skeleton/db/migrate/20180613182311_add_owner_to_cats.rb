class AddOwnerToCats < ActiveRecord::Migration[5.1]
  def change
    add_column :cats, :owner_id, :integer, null: false
  end
end
