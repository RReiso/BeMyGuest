module ApplicationHelper
  def full_title(page_title = '')
    main_title = 'BeMyGuest'
    page_title.empty? ? main_title : "#{page_title} | #{main_title}"
  end

  def flash_danger(action, model)
    flash[:danger] = "Error #{action} #{model}. Please try again."
  end

  def initials(current_user)
    current_user.name[0..1].upcase
  end
end
