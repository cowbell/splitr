class SessionsController < ApplicationController
  def new
    @session = Session.new
  end

  def create
    @session = Session.new(session_params)
    if @session.valid?
      session[:user_id] = @session.user_id
      redirect_to root_url, notice: "You have been successfully logged in."
    else
      render "new"
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_url, notice: "You have been successfully logged out."
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
