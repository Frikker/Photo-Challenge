ActiveAdmin.register Photopost do
  batch_action 'ban' do |ids|
    batch_action_collection.find(ids).each(&:ban!)
    PhotopostWorker::DeletePhotopost.perform_in(5.minute, params[:id])

  end

  batch_action 'approve' do |ids|
    batch_action_collection.find(ids).each(&:approve!)
  end

  batch_action 'delete' do |ids|
    batch_action_collection.find(ids).each(&:delete_post!)
  end

  index do
    selectable_column
    column :content
    column :photo do |post|
      image_tag post.picture.admin.url unless post.picture.url.nil?
    end
    column :aasm_state
    column :moderation do |pg|
      columns do
        if pg.aasm_state == 'moderating'
          column do
            link_to 'approve', approve_admin_photopost_path(pg), class: 'button2'
          end
          column do
            link_to 'ban', ban_admin_photopost_path(pg), class: 'button1'
          end
        elsif pg.aasm_state == 'approved'
          column do
            link_to 'ban', ban_admin_photopost_path(pg), class: 'button1'
          end
        elsif pg.aasm_state == 'deleted'
          column do
            link_to 'restore', restore_admin_photopost_path(pg), class: 'button2'
          end
        else
          column do
            link_to 'approve', approve_admin_photopost_path(pg), class: 'button2'
          end
        end
      end
    end
  end

  member_action :approve do
    photo = Photopost.find_by(id: params[:id])
    resource.approve!
    redirect_to admin_photoposts_path
  end

  member_action :ban do
    photo = Photopost.find_by(id: params[:id])
    resource.ban!
    PhotopostWorker::DeletePhotopost.perform_in(5.minute, params[:id])
    redirect_to admin_photoposts_path
  end

  member_action :restore do
    resource.restore!
    redirect_to admin_photoposts_path
  end
end