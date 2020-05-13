class UsersController < ApplicationController
  before_action :authenticate_user!

  before_action :ensure_correct_user,{only: [:edit, :update]}

  def new
   @books = Book.all
   @book = Book.new
 end

 def index
   @users = User.all
   @books = Book.all
   @book = Book.new
   @user = current_user
 end

 def show
  @user = User.find(params[:id])
  @book = Book.new
  @books = @user.books
end

def edit
  @user = User.find(params[:id])
end

def update
 @user = User.find(params[:id])
 if @user.update(user_params)
  redirect_to user_path(@user.id), notice: 'User was successfully created.'
else
 render action: :edit
end
end

def ensure_correct_user

 if current_user.id !=  params[:id].to_i

   redirect_to user_path(current_user.id)

 end
end

private

def user_params
  params.require(:user).permit(:name, :introduction, :profile_image)
  
end
end
