module ApplicationHelper
  def last_reply_time(post)
    @last_reply_time = post.replies.last.created_at
    return  @last_reply_time
  end 
end
