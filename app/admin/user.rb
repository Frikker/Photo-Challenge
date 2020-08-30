ActiveAdmin.register User do
  menu priority: 2

  index as: :table do
    column :first_name
    column :last_name
    column :nickname
    state_column :aasm_state
  end
end