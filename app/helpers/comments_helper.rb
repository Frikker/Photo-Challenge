module CommentsHelper
  def parent_comment(comment)
    Comment.find(comment).user.first_name
  end
end
