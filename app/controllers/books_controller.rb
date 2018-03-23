class BooksController < ApplicationController
	skip_before_action :verify_authenticity_token
	before_action :authorize
	def new
		@book = Book.new
		respond_to do |format|
			format.json { render json: {book: @book}, status: :ok }
			format.html {}
		end
	end

	def show
		begin
			@book = Book.find(params[:id])
			respond_to do |format|
				format.json { render json: {book:@book}, status: :ok }
				format.html {}
			end
		rescue ActiveRecord::RecordNotFound => e
			respond_to do |format|
				format.json { render json: {error:e.message}, status: :not_found}
			end
		end
	end

	def create
		begin
			@book = Book.new(book_params)
			respond_to do |format|
				if @book.save
					format.json { render json: { book: @book}, status: :created }
				else
					format.json { render json: @book.errors, status: :unprocessable_entity }
				end
			end
		rescue ActiveRecord::InvalidForeignKey => e
			respond_to do |format|
				format.json { render json: {error:'Invalid Foreign Key'}, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		begin
			@book = Book.find(params[:id])
			respond_to do |format|
				@book.destroy
				format.json { render json: {}, status: :ok }
			end  
		rescue ActiveRecord::RecordNotFound => e
			respond_to do |format|
				format.json { render json: {error:e.message}, status: :unprocessable_entity }
			end
		end
	end

	def index
		@books = Book.all
		respond_to do |format|
			format.json { render json: {books:@books}, status: :ok }
			format.html {}
		end
	end

	def edit
		begin
			@book = Book.find(params[:id])
			respond_to do |format|
				format.json { render json: {book:@book}, status: :ok }
				format.html {}
			end
		rescue ActiveRecord::RecordNotFound => e
			respond_to do |format|
				format.json { render json: {error:e.message}, status: :not_found }
			end
		end
	end

	def update
		begin
			@book = Book.find(params[:id])
			respond_to do |format|
				if @book.update(book_params)
					format.json { render json: {book:@book}, status: :ok }
				else
					format.json { render json: @book.errors, status: :unprocessable_entity }
				end
			end
		rescue => e
			respond_to do |format|
				format.json { render json: {error:e.message}, status: :unprocessable_entity }
			end
		end
	end

	private
	def book_params
		params.require(:book).permit(:name, :price, :code, :author, :publication, :version, :no_of_copies, :library_id, :category_id)
	end
end