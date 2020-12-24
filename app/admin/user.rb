# frozen_string_literal: true

ActiveAdmin.register User do
  menu priority: 2
  actions :index, :edit, :show
  filter :aasm_state, as: :select, label: 'State'

  index as: :table do
    column I18n.t('admin.content') do |user|
      link_to image_tag(user.image.avatar.url), admin_user_path(user.id)
    end
    column I18n.t('admin.first_name'), :first_name
    column I18n.t('admin.last_name'), :last_name
    column I18n.t('admin.nickname'), :nickname
    column I18n.t('admin.link') do |u|
      link_to u.urls, u.urls
    end
    column I18n.t('admin.photoposts') do |user|
      user.photoposts.count
    end
    column I18n.t('admin.rating') do |user|
      user.ratings.count
    end
    column I18n.t('admin.comments') do |user|
      user.comments.count
    end
    state_column I18n.t('admin.status'), :aasm_state
    column I18n.t('admin.moderate') do |user|
      link_to 'Edit', edit_admin_user_path(user.id)
    end
  end

  show do |f|
    render 'show_form', user: f
    tabs do
      tab "#{I18n.t('admin.photoposts')} #{f.photoposts.count}" do
        render 'photoposts', photoposts: f.photoposts
      end
      tab "#{I18n.t('admin.comments')} #{f.comments.count}" do
        render 'comments', comments: f.comments.page(params[:page])
      end
      tab "#{I18n.t('admin.rating')} #{f.ratings.count}" do
        render 'rating', ratings: f.ratings.page(params[:page])
      end
    end
  end

  form do |f|
    f.para 'Ban reason: ' + f.object.ban_reason unless f.object.ban_reason.blank?
    image_tag f.object.image.admin.url
    f.para f.object.first_name + ' ' + f.object.last_name, class: 'reported-name'
    f.para link_to f.object.nickname, f.object, class: 'name-link'
    tabs do
      tab 'Reports' do
        render 'report_table'
      end
      tab 'Photoposts' do
        render 'photoposts', photoposts: f.object.photoposts
      end
    end
    if f.object.banned?
      f.button 'Restore', formaction: :restore
    else
      f.input :ban_reason
      f.button 'Ban', formaction: :ban
    end
  end

  member_action :ban, method: :patch do
    resource.ban_reason = params[:user][:ban_reason]
    resource.ban!
    redirect_to edit_admin_user_path(resource.id)
  end

  member_action :restore, method: :patch do
    resource.ban_reason = ''
    if ReportReason.find_by(user_id: resource.id).nil?
      resource.restore!
    else
      resource.report!
    end
    redirect_to edit_admin_user_path(resource.id)
  end
end
