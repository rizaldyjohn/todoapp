class SessionsController < ApplicationController
  # before_action :set_user, only: :destroy

  def new
  end

  def create
    # @user = User.new(user_params)
    @user = User.where("LOWER(email) = ?", params[:email].downcase).first

    if @user && @user.authenticate(params[:password])
      current_session.user = @user
      redirect_to root_path, notice: 'Signed in successfully'
    else
      redirect_to new_session_path, notice: 'Invalid email or password'
    end
  end

  def destroy
    current_session.destroy
    redirect_to root_path, notice: 'Signed out successfully'
  end
end
