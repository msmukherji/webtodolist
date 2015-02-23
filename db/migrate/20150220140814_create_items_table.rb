class CreateItemsTable < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.datetime :due
      t.string :completed
      t.string :list_id
    end
  end
end
