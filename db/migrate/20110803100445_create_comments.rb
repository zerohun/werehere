class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :mention
      t.integer :user_id
      t.integer :history_id

      t.timestamps
    end
  end
end
