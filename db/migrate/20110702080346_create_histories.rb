class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.string :url

      t.timestamps
    end
  end
end
