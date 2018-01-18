class CategoriesController < ApplicationController
	skip_before_action :verify_authenticity_token
	def new
		@category = Category.new
		respond_to do |format|
			format.json { render json: {category: @category}, status: :ok }
		end
	end

	def show
		begin
			@category = Category.find(params[:id])
			respond_to do |format|
				format.json { render json: {category:@category}, status: :ok }
			end
		rescue ActiveRecord::RecordNotFound => e
			respond_to do |format|
				format.json { render json: {error:e.message}, status: :not_found}
			end
		end
	end

	def create
		@category = Category.new(category_params)
		respond_to do |format|
			if @category.save
				format.json { render json: { category: @category}, status: :created }
			else
				format.json { render json: @category.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		begin
			@category = Category.find(params[:id])
			respond_to do |format|
				@category.destroy
				format.json { render json: {}, status: :ok }
			end  
		rescue ActiveRecord::RecordNotFound => e
			respond_to do |format|
				format.json { render json: {error:e.message}, status: :unprocessable_entity }
			end
		end
	end

	def index
		@categories = Category.all
		respond_to do |format|
			format.json { render json: {categories:@categories}, status: :ok }
		end
	end

	def edit
		begin
			@category = Category.find(params[:id])
			respond_to do |format|
				format.json { render json: {category:@category}, status: :ok }
			end
		rescue ActiveRecord::RecordNotFound => e
			respond_to do |format|
				format.json { render json: {error:e.message}, status: :not_found }
			end
		end
	end

	def update
		begin
			@category = Category.find(params[:id])
			respond_to do |format|
				if @category.update(category_params)
					format.json { render json: {category:@category}, status: :ok }
				else
					format.json { render json: @category.errors, status: :unprocessable_entity }
				end
			end
		rescue ActiveRecord::RecordNotFound => e
			respond_to do |format|
				format.json { render json: {error:e.message}, status: :unprocessable_entity }
			end
		end
	end

	private
	def category_params
		params.require(:category).permit(:name)
	end
end
