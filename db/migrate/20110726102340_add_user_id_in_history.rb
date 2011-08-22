class AddUserIdInHistory < ActiveRecord::Migration
  def up
    add_column :histories, :user_id, :integer
  end

  def down
    remove_column :histories, :user_id
  end
end
