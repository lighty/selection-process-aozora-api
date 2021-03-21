class WritersController < ApplicationController
  def index
    writers = Writer.where('name like ?', "%#{params[:q]}%")
    render json: writers
  end
end
