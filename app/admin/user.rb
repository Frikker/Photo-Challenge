ActiveAdmin.register User do
  menu priority: 2

  index as: :table do
    column :first_name
    column :last_name
    column :nickname
    state_column :aasm_state
    column 'Reports' do |user|
      link_to 'See reports', edit_admin_user_path(user.id) if user.aasm_state == 'reported'
    end
  end

  form do |f|
    image_tag f.object.image
    f.para f.object.first_name + ' ' + f.object.last_name, class: 'reported-name'
    f.para link_to f.object.nickname, f.object, class: 'name-link'
    render partial: 'report_table'

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
