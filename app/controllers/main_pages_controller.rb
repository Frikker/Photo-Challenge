class MainPagesController < ApplicationController
  def index
    @photoposts = Photopost.all.order(created_at: :desc).paginate(page: params[:page])
  end

  def rules
  end

  def contacts
  end
end
