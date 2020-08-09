# frozen_string_literal: true

ActiveAdmin.register Photopost do
  menu priority: 1
  batch_action 'ban' do |ids|
    batch_action_collection.find(ids).each do |post|
      post.ban!
      PhotopostWorker::DeletePhotopost.perform_in(5.minute, post.id)
    end
  end

  batch_action 'approve' do |ids|
    batch_action_collection.find(ids).each(&:approve!)
  end

  index as: :table do
    selectable_column
    column :content
    column :photo do |post|
      image_tag post.picture.admin.url unless post.picture.url.nil?
    end
    state_column :aasm_state
    column :moderation do |post|
      columns do
        if post.aasm_state == 'moderating'
          column do
            link_to 'approve', approve_admin_photopost_path(post), class: 'button2'
          end
          column do
            link_to 'ban', ban_admin_photopost_path(post), class: 'button1'
          end
        elsif post.aasm_state == 'approved'
          column do
            link_to 'ban', ban_admin_photopost_path(post), class: 'button1'
          end
        elsif post.aasm_state == 'deleted'
          column do
            link_to 'restore', restore_admin_photopost_path(post), class: 'button3'
          end
        else
          column do
            link_to 'approve', approve_admin_photopost_path(post), class: 'button2'
          end
        end
      end
    end
  end

  member_action :approve do
    resource.approve!
    redirect_to admin_photoposts_path
  end

  member_action :ban do
    resource.ban!
    PhotopostWorker::DeletePhotopost.perform_in(5.minute, params[:id])
    redirect_to admin_photoposts_path
  end

  member_action :restore do
    resource.restore!
    redirect_to admin_photoposts_path
  end
end
