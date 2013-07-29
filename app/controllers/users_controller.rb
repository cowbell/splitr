class UsersController < ApplicationController
  def new
    @user = User.new
    authorize! :create, @user
  end

  def create
    @user = User.new
    authorize! :create, @user
    if @user.update(user_params)
      session[:user_id] = @user.id
      redirect_to root_url, notice: "Thank you for registering in Splitr."
    else
      render "new"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
