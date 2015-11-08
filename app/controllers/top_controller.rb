class TopController < ApplicationController
  # before_action :to_root, only: :about

  def index
    render :layout => 'index_layout'
  end

  def about
    render :layout => 'about_layout'
  end

  private

  def to_root
    redirect_to :root and return
  end
end
