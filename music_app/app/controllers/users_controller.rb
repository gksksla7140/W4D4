class UsersController < ApplicationController

  def new
    @user= User.new
    render :new
  end
  def index
    @user = User.all
    render :index


  end

  def show
    @user = User.find_by_credential(
      params[:email],
      params[:password]
    )
    render :show ,user: @user
  end
  def create
    @user = User.new(user_param)

    if @user.save!
      flash[:notice]='Successful in making an account'
      redirect_to user_url(@user)
    else
      flash.now[:errors]=@user.errors.full_messages
      render :new
    end

  end





  private
  def user_param
    params.require(:user).permit(:email, :name, :password)

  end


end
