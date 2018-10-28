module ApplicationHelper
  def last_reply_time(post)
    @last_reply_time = post.replies.last.created_at
    return  @last_reply_time
  end

  def access_right_select
    [["所有人", 0],["朋友跟自己", 1],["只有自己", 2]]
  end 
end
