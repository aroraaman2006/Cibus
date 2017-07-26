class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authorize, except: [:new, :create]

  def index
    if current_user.admin == true
      @users = User.all
    else
      redirect_to root_url, notice: "Access Denied!"
    end
    
  end

  def show
  end

  def new
    if current_user
      redirect_to root_url, notice: 'Already Logged In, To register as new user, logout first!'
    else
      @user = User.new
    end
  end

  def edit
  end

  def create
    @user = User.new(user_params)    
    if @user.save
    	session[:user_id] = @user.id
      redirect_to root_url, notice: 'Registration successful, you are now logged in.'
    else
    render :new
    end
  end

  def update
    
      if @user.update(user_params)
      redirect_to @user, notice: 'Profile was successfully updated!'
      else
      render :edit
      end
  end

  def destroy
    @user.destroy
      redirect_to users_url, notice: 'Profile was successfully destroyed!'
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end