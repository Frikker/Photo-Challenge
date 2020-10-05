# frozen_string_literal: true

ActiveAdmin.register Photopost do
  menu priority: 1
  filter :aasm_state, as: :select

  index as: :table do
    column :content
    column :photo do |post|
      image_tag post.picture.admin.url unless post.picture.url.nil?
    end
    state_column :aasm_state
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
    redirect_to admin_photoposts_path
  end

  member_action :ban, method: :patch do
    resource.ban!
    PhotopostWorker::DeletePhotopost.perform_in(10.minute, params[:id])
    redirect_to admin_photoposts_path
  end

  member_action :restore do
    resource.restore!
    redirect_to admin_photoposts_path
  end
end
