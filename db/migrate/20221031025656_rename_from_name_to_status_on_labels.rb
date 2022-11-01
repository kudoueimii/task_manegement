class RenameFromNameToStatusOnLabels < ActiveRecord::Migration[6.1]
  def change
    rename_column :labels, :name, :status
  end
end
