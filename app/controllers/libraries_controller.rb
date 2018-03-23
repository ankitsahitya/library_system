class LibrariesController < ApplicationController
	skip_before_action :verify_authenticity_token
	before_action :authorize
	def new
		@library = Library.new
		respond_to do |format|
			format.json { render json: {library: @library}, status: :ok }
			format.html {}
		end
	end

	def show
		begin
			@library = Library.find(params[:id])
			respond_to do |format|
				format.json { render json: {library:@library}, status: :ok }
				format.html {}
			end
		rescue ActiveRecord::RecordNotFound => e
			respond_to do |format|
				format.json { render json: {error:e.message}, status: :not_found}
			end
		end
	end

	def create
		@library = Library.new(library_params)
		respond_to do |format|
			if @library.save
				format.json { render json: { library: @library}, status: :created }
			else
				format.json { render json: @library.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		begin
			@library = Library.find(params[:id])
			respond_to do |format|
				@library.destroy
				format.json { render json: {}, status: :ok }
			end  
		rescue ActiveRecord::RecordNotFound => e
			respond_to do |format|
				format.json { render json: {error:e.message}, status: :unprocessable_entity }
			end
		end
	end

	def index
		@libraries = Library.all
		respond_to do |format|
			format.json { render json: {libraries:@libraries}, status: :ok }
			format.html {}
		end
	end

	def edit
		begin
			@library = Library.find(params[:id])
			respond_to do |format|
				format.html {}
				format.json { render json: {library:@library}, status: :ok }
			end
		rescue ActiveRecord::RecordNotFound => e
			respond_to do |format|
				format.json { render json: {error:e.message}, status: :not_found }
			end
		end
	end

	def update
		begin
			@library = Library.find(params[:id])
			respond_to do |format|
				if @library.update(library_params)
					format.json { render json: {library:@library}, status: :ok }
				else
					format.json { render json: @library.errors, status: :unprocessable_entity }
				end
			end
		rescue ActiveRecord::RecordNotFound => e
			respond_to do |format|
				format.json { render json: {error:e.message}, status: :unprocessable_entity }
			end
		end
	end

	private
	def library_params
		params.require(:library).permit(:name, :address, :phone_no)
	end
end
