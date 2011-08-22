class CommentObserver < ActiveRecord::Observer
  observe :comment

  def after_save(record)
    record.history.last_comment_id = record.id
  end

end
