class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update]
  
  before_filter :require_admin, :only => [:add_user, :create_user]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    
    #@user.set_admin(User.count == 0)  #first person signed up is an admin
    
    if @user.save
      flash[:notice] = "Account registered!"
      redirect_back_or_default websites_url
    else
      render :action => :new
    end
  end
  
  def add_user
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Account registered!"
      redirect_back_or_default websites_url
    else
      render :action => :new
    end
  end
  
  def show
    @user = @current_user
  end
 
  def edit
    @user = @current_user
  end
  
  def add_user
    @user = User.new
  end
  
  def update
    @user = @current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to websites_url
    else
      render :action => :edit
    end
  end
end
