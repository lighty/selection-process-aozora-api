class WorksController < ApplicationController
  def index
    works = Work.where('name like ?', "%#{params[:q]}%").limit(100)
    render json: works
  end
end
