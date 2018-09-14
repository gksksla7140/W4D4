class UsersController < ApplicationController



  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login!(@user)
      flash[:notice] = 'Successfully created your account! Check your inbox for an activation email.'
      redirect_to cats_url
    else
        flash.now[:errors] = @user.errors.full_messages
        render :new
    end




  end


  private
  def user_params
    params.require(:user).permit(:email ,:password,:name )

  end

end
