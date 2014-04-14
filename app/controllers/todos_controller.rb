class TodosController < ApplicationController
  def index
    @todos = Todo.all
  end
  def new
    @todo = Todo.new
  end

  def create
    @todo = Todo.new(todo_params)
    
    if @todo.save
      location_string = @todo.name.split('at').last.strip
      locations = location_string.split(/\,|and/).map(&:strip)
      locations.each do |location|
        @todo.tags.create(name: "location:#{location}")
      end
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
