class Api::ListsController < ApiController
  before_action :authenticated?

  rescue_from Pundit::NotAuthorizedError do
    render json: {errors: 'You are not authorized'}, status: :not_authorized
  end

  def show
    list = List.find(params[:id])
    raise Pundit::NotAuthorizedError unless ListPolicy.new(current_user, list).show?
    render json: list
  end

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
    raise Pundit::NotAuthorizedError unless ListPolicy.new(current_user, list).update?
    if list.update(list_params)
      render json: list
    else
      render json: { errors: list.errors.full_messages }, status: :unprocessable_entity
    end
  end


  def index
    lists = ListPolicy::Scope.new(List.all, current_user).resolve
    render json: lists
  end

  private
    def list_params
      params.require(:list).permit(:title, :permissions)
    end

end
