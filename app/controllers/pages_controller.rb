class PagesController < ApplicationController
  def front
    redirect_to todos_path if current_user
  end
end
