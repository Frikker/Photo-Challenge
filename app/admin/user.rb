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

  form do |user|
    para user.object.first_name + ' ' + user.object.last_name
    para :nickname
    tab 'Reports' do |row|
      report = ReportReason.find_by(user_id: user.object.id)
      column eval "#{report.reason_class}.find(#{report.reason_id}).content"
      column image_tag(Photopost.find(report.reason_id).picture.admin.url)
    end
  end
end
