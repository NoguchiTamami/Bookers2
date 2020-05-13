class BooksController < ApplicationController
  before_action :authenticate_user!


  def new
    @book = Book.new
  end

  def create
  	@book = Book.new(book_params)
    @book.user = current_user
    if @book.save
      redirect_to book_path(@book.id), notice: 'Book was successfully created.'
    else
      @books = Book.all
      @user = current_user
      render action: :index
    end
  end

  def index
   @books = Book.all
   @book = Book.new
   @user = current_user
 end

 def show
   @book_new = Book.new
   @book = Book.find(params[:id])
   @user = @book.user
 end

 def edit
  @book = Book.find(params[:id])
  unless current_user.id == @book.user.id
    redirect_to books_path
  end
  @user = current_user
end

def update
 @book = Book.find(params[:id])
 if @book.update(book_params)
  redirect_to book_path(@book), notice: 'Book was successfully created.'
else
 render action: :edit
end
end


def destroy
  @book = Book.find(params[:id]) 
  @book.destroy 
  redirect_to books_path 
end

private
def book_params
  params.require(:book).permit(:title, :body)
end

end