class DropLabels < ActiveRecord::Migration[6.1]
  def change
    remove_column :labels, :name
  end
end
