class WorksController < ApplicationController
  def index
    works = Work.where('name like ?', "%#{params[:q]}%")
    render json: works
  end
end
