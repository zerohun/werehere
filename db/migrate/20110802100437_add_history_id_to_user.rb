class AddHistoryIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :history_id, :integer
  end
end
