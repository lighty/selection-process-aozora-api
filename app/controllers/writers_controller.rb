class WritersController < ApplicationController
  def index
    writers = Writer.where('name like ?', "%#{params[:q]}%").limit(100)
    render json: writers
  end
end
