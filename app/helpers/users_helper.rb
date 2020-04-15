module UsersHelper

  def banned_photoposts
    flash[:danger] = "You Got #{@banned_photoposts.count} Photopost Under Delete" if @banned_photoposts.any?
  end
end
