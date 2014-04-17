class TodosController < ApplicationController
  before_filter :require_user

  def index
    @todos = Todo.all
  end
  def new
    @todo = Todo.new
  end

  def create
    @todo = Todo.new(todo_params)
    
    if @todo.save_with_tags
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @todo = Todo.find(params[:id])
  end

private
  def todo_params
    params.require(:todo).permit(:name, :description)
  end
end
