class CatsController < ApplicationController


  def index
    @cat = Cat.all
    render :index
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create

    if @cat.save
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :new
    end
  end

  private

  def cat_params
    params.require(:cat)
      .permit(:age, :birth_date, :color, :description, :name, :sex)
  end
end
