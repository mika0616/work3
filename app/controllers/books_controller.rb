class BooksController < ApplicationController
before_action :authenticate_user!
	def index
		@nbook = Book.new
		@books = Book.all.reverse_order
		@user = current_user
	end

	def create
		@nbook = Book.new(book_params)
		@nbook.user_id = current_user.id
		if @nbook.save
			flash[:notice] = "You have creatad book successfully."
			redirect_to book_path(@nbook.id)
		else
			@books = Book.all.reverse_order
			@user = current_user
			render action: :index
		end
	end

	def show
		@nbook = Book.new
		@book = Book.find(params[:id])
		@user = current_user
	end

	def edit
		@book = Book.find(params[:id])
		if @book.user != current_user
			redirect_to books_path
		end
	end

	def update
		@book = Book.find(params[:id])
		if @book.update(book_params)
			flash[:notice] = "You have updated book successfully."
			redirect_to book_path(@book.id)
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
		params.require(:book).permit(:title,:body)
	end
end
