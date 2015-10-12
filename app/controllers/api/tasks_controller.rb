class Api::TasksController < ApiController
  before_action :authenticated?

  def create
    list = List.find(params[:list_id])
    task = Task.new(task_params)

    if task.save
      render json: task
    else
      render json: {errors: task.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def update
    task = Task.find(params[:id])
    if task.update(task_params)
      render json: task
    else
      render json: { errors: task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def index
  end
  
  private
    def task_params
      params.require(:task).permit(:title)
    end
end
