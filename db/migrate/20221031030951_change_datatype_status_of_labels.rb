class ChangeDatatypeStatusOfLabels < ActiveRecord::Migration[6.1]
  def change
    change_column :labels, :status, 'integer USING CAST(status AS integer)'
  end
end
