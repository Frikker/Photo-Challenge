# frozen_string_literal: true

ActiveAdmin.register User do
  menu priority: 2
  actions :all, except: :new
  filter :aasm_state, as: :select, label: 'State'

  index as: :table do
    column :first_name
    column :last_name
    column :nickname
    column 'Social link' do |u|
      link_to u.urls, u.urls
    end
    state_column 'State', :aasm_state
    column 'Moderation' do |user|
      link_to 'Edit', edit_admin_user_path(user.id)
    end
  end

  form do |f|
    image_tag f.object.take_image
    f.para f.object.first_name + ' ' + f.object.last_name, class: 'reported-name'
    f.para link_to f.object.nickname, f.object, class: 'name-link'
    tabs do
      tab 'Reports' do
        render partial: 'report_table'
      end
      tab 'Photoposts' do
        render partial: 'photoposts'
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
