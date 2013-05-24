class SessionsController < ApplicationController
  skip_before_filter :require_user, only: [:new, :create]

  def new
  end

  def create
    @user = User.find_by_email(params[:email].downcase)

    if @user.present? && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to root_url, notice: "Signed in successfully."
    else
      flash[:notice] = "Something went wrong. Please try again."
      render 'new'
    end
  end

  def destroy
    reset_session
    redirect_to root_url, notice: "Signed out successfully."
  end
end
