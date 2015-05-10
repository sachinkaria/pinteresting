class AddDateToPins < ActiveRecord::Migration
  def change
    add_column :pins, :date, :date
  end
end
