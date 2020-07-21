class ChangeColumnToComment < ActiveRecord::Migration[5.2]
  def change
    change_column :comments, :content, :string, limit: 600
  end
end
