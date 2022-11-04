class RenameFromNameToStatusOnLabels < ActiveRecord::Migration[6.1]
  def up
    remove_column :labels, :name
  end

  def down
    remove_column :labels, :name, :status
  end
end
