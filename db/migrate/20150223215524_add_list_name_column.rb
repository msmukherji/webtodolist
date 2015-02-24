class AddListNameColumn < ActiveRecord::Migration
  def change
    add_column :items, :list_name, :string
  end
end
