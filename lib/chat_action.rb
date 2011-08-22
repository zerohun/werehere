class ChatAction < Cramp::Action
  on_start :pop_comment, :every => 5
  @@comments = []
  @@count = 0

  def self.push_comment(comment)
    puts 'push!!'
    puts comment[:history_id]
    puts comment[:mention]
    @@comments.push(comment)
  end
  def self.notify_for_new_comment(notify_hash)
    @@notify_hash = notify_hash
  end

  def pop_comment
    puts params.to_s
    while(true)
      @@comments.each do |comment|
        if comment[:history_id] == params[:history_id]
          render comment[:mention]
          finish
        end
      end
    end
  end
end
