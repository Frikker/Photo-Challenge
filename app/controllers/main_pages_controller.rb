class MainPagesController < ApplicationController
  def index
    @photoposts = Photopost.custom_order(params[:order_by], params[:order_type]).page  params[:page]
  end

  def rules
  end

  def contacts
  end
end
