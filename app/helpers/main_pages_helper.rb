module MainPagesHelper
  def full_title(page_title = '')
    base_title = ' | Challenge your friends in photo mastery'
    page_title.empty? ? base_title : page_title + base_title
  end

  def logged_in?
    false
  end

  def new_line(photopost)
    (@photoposts.index(photopost) % 3).zero?
  end
end
