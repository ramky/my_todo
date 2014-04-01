class TagsController < ApplicationController
  def create
    @todo = Todo.find(params[:todo_id])
    @tag = @todo.tags.build(tag_params)
    
    if @tag.save
      redirect_to root_path
    else
      render :new
    end
  end

private
  def tag_params
    params.require(:tag).permit(:name)
  end
end
