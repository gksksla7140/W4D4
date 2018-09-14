class SessionsController < ApplicationController
  def new
    render :new

  end

  def destroy
    logout!
    redirect_to new_session_url

  end

  def create

    @user = User.find_by_credential(
      params[:user][:email],
      params[:user][:password]
    )

    if @user.nil?
      flash.now[:errors] = ["Incorrect username and/or password"]
      render :new
    else
      login!(@user)
      redirect_to cats_url
    end



  end

end
