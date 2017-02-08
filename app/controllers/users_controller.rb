class UsersController < ApplicationController
  before_action :logged_in_user , only: [:show,:edit,:update,:destroy,:index]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id:params[:id])
  end

  def new
    @user = User.new
  end

  def edit
  end
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Successfully created account and logged in."
      log_in @user
      redirect_to @user
    else
        flash.now[:danger] = "Account is not created"
        render 'new'
    #binding.pry
    end
  end

  def update
  end

  def destroy
  end

  private
    def set_user
      @user = User.find(params[:id])
    end
    
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
