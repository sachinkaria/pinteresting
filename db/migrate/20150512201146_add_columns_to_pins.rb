class AddColumnsToPins < ActiveRecord::Migration
  def change
    add_column :pins, :category_id, :string
  end
end
