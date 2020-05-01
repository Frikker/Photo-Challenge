# frozen_string_literal: true

class MainPagesController < ApplicationController
  def index
    @photoposts = Photopost.custom_order(params[:order_by], params[:order_type]).page params[:page]
  end

  def rules
    render 'main_pages/rules'
  end

  def contacts
    render 'contacts'
  end
end
