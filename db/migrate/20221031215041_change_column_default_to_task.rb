class ChangeColumnDefaultToTask < ActiveRecord::Migration[6.1]
  def change
    change_column_default :tasks, :status, from: nil, to: "0", null: false
  end
end
