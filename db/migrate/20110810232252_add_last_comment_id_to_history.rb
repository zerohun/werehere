class AddLastCommentIdToHistory < ActiveRecord::Migration
  def change
    add_column :histories, :last_comment_id, :integer
  end
end
