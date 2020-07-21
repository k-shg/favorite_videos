class ChangeColumnToComment < ActiveRecord::Migration[5.2]
  def change
    change_column :Comments, :content, :string, limit: 600
  end
end
