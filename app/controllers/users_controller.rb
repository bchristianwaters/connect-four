class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = current_user
    @user.assign_attributes(user_params)
    
    if @user.save
      render :show  
    else
      render :edit
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :age)
  end
end
