class ChangeDatatypeStatusOfLabels < ActiveRecord::Migration[6.1]
  def up
    remove_column :labels, :status
  end

  def down
    change_column :labels, :status, 'integer USING CAST(status AS integer)'
  end
end
