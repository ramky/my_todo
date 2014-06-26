class TodosController < AuthenticatedController

  def index
    @todos = current_user.todos
  end

  def new
    @todo = Todo.new
  end

  def create
    @todo = Todo.new(todo_params)

    if @todo.save_with_tags(current_user)
      AppMailer.notify_on_new_todo(current_user, @todo).deliver
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @todo = Todo.find_by_token(params[:id])
  end

private
  def todo_params
    params.require(:todo).permit(:name, :description)
  end
end
