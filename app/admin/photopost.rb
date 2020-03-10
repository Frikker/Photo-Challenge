ActiveAdmin.register Photopost do
  batch_action I18n.t(:ban) do |ids|
    batch_action_collection.find(ids).each(&:ban!)
  end

  batch_action I18n.t(:approve) do |ids|
    batch_action_collection.find(ids).each(&:approve!)
  end

  batch_action I18n.t(:delete) do |ids|
    batch_action_collection.find(ids).each(&:delete_post!)
  end

  index do
    selectable_column
    column :content
    column :photo do |post|
      image_tag post.picture.admin.url
    end
  end
end