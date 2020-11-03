# frozen_string_literal: true

ActiveAdmin.register Photopost do
  menu priority: 1
  actions :all, except: :new
  filter :aasm_state, as: :select, label: 'State'

  index as: :table do
    column :content
    column :photo do |post|
      link_to image_tag(post.picture.admin.url), post.picture.url, target: '_blank' unless post.picture.url.nil?
    end
    column 'Rating', :rating_count
    column 'Comments', :comments_count
    state_column 'State', :aasm_state
    column :moderation do |post|
      columns do
        if post.moderating?
          column do
            link_to 'approve', approve_admin_photopost_path(post), class: 'button2'
          end
          column do
            link_to 'ban', edit_admin_photopost_path(post), class: 'button1'
          end
        elsif post.approved?
          column do
            link_to 'ban', edit_admin_photopost_path(post), class: 'button1'
          end
        else
          column do
            link_to 'approve', approve_admin_photopost_path(post), class: 'button2'
          end
        end
      end
    end
  end

  form partial: 'ban_form'

  member_action :approve do
    resource.ban_reason = ''
    resource.approve!
    photoposts_counter = resource.user.photoposts
    if photoposts_counter.count == 1 || (photoposts_counter.count > 1 &&
        UserAchievement.find_by(achievement_id: Achievement.find_by_name('Первые шаги!'), user_id: resource.user.id).nil?)
      UserAchievement.create!(user_id: resource.user.id,
                              photopost_id: resource.id,
                              achievement_id: Achievement.find_by_name('Первые шаги!').id)
    elsif photoposts_counter.count == 5 || (photoposts_counter.count > 5 &&
        UserAchievement.find_by(achievement_id: Achievement.find_by_name('Уже не маленький'), user_id: resource.user.id).nil?)
      UserAchievement.create!(user_id: resource.user.id,
                              photopost_id: resource.id,
                              achievement_id: Achievement.find_by_name('Уже не маленький').id)
    end
    redirect_to admin_photoposts_path
  end

  member_action :ban, method: :patch do
    resource.ban_reason = params[:photopost][:ban_reason]
    resource.ban!
    UserAchievement.find_by_photopost_id(resource.id)&.delete!
    PhotopostWorker::DeletePhotopost.perform_in(10.minute, params[:id])
    redirect_to admin_photoposts_path
  end

  member_action :restore do
    resource.restore!
    redirect_to admin_photoposts_path
  end
end
