class ListsController < ApplicationController
  def show
    @list = List.find(params[:id])
    if ListPolicy.new(current_user, @list).show?
    else
      redirect_to :root, error: 'Not Authorized to do that'
    end
  end
end
