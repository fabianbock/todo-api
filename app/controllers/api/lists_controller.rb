class Api::ListsController < ApiController
before_action :authenticated?

  def create
  end

  def destroy
    begin
      list = List.find(params[:id])
      list.destroy

      render json: {}, status: :no_content
    rescue ActiveRecord::RecordNotFound
      render :json => :status => :not_found
    end
  end

end
