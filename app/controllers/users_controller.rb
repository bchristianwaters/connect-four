class UsersController < ApplicationController
  def show
    before_action :authenticate_user!
    @user = User.find(params[:id])
  end

  def edit
    before_action :authenticate_user!
    @user = User.find(params[:id])
  end
  
  def update
    before_action :authenticate_user!
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
