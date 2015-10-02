class Api::ListsController < ApiController
before_action :authenticated?

  def create
    list = List.new(list_params)
    
    if list.save
      render json: list
    else
      render json: {errors: list.errors.full_messages}, status: :unprocessable_entity
    end
  end


  def destroy
    begin
      list = List.find(params[:id])
      list.destroy

      render json: {}, status: :no_content
    rescue ActiveRecord::RecordNotFound
      render json: {}, status: :not_found
    end
  end



# PUT /api/users/5/lists/17  params={list: {title: 'changed_list', permissions: 'public'}}
  def update
    list = List.find(params[:id])
    if list.update(list_params) && (list.permissions == "private" || list.permissions == "viewable" || list.permissions == "open")
      render json: list
    else
      render json: { errors: list.errors.full_messages }, status: :unprocessable_entity
    end


  end

  private
    def list_params
      params.require(:list).permit(:title, :permissions)
    end

end
