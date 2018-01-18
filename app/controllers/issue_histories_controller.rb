class IssueHistoriesController < ApplicationController
	skip_before_action :verify_authenticity_token
	def new
		@issueHistory = IssueHistory.new
		respond_to do |format|
			format.json { render json: {issue_history: @issueHistory}, status: :ok }
		end
	end

	def show
		begin
			@issueHistory = IssueHistory.find(params[:id])
			respond_to do |format|
				format.json { render json: {issue_history:@issueHistory}, status: :ok }
			end
		rescue ActiveRecord::RecordNotFound => e
			respond_to do |format|
				format.json { render json: {error:e.message}, status: :not_found}
			end
		end
	end

	def create
		begin
			@issueHistory = IssueHistory.new(issueHistory_params)
			respond_to do |format|
				if @issueHistory.save
					format.json { render json: { issue_history: @issueHistory}, status: :created }
				else
					format.json { render json: @issueHistory.errors, status: :unprocessable_entity }
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
			@issueHistory = IssueHistory.find(params[:id])
			respond_to do |format|
				@issueHistory.destroy
				format.json { render json: {}, status: :ok }
			end  
		rescue ActiveRecord::RecordNotFound => e
			respond_to do |format|
				format.json { render json: {error:e.message}, status: :unprocessable_entity }
			end
		end
	end

	def index
		@issueHistories = IssueHistory.all
		respond_to do |format|
			format.json { render json: {issue_histories:@issueHistories}, status: :ok }
		end
	end

	def edit
		begin
			@issueHistory = IssueHistory.find(params[:id])
			respond_to do |format|
				format.json { render json: {issue_history:@issueHistory}, status: :ok }
			end
		rescue ActiveRecord::RecordNotFound => e
			respond_to do |format|
				format.json { render json: {error:e.message}, status: :not_found }
			end
		end
	end

	def update
		begin
			@issueHistory = IssueHistory.find(params[:id])
			respond_to do |format|
				if @issueHistory.update(issueHistory_params)
					format.json { render json: {issue_history:@issueHistory}, status: :ok }
				else
					format.json { render json: @issueHistory.errors, status: :unprocessable_entity }
				end
			end
		rescue => e
			respond_to do |format|
				format.json { render json: {error:e.message}, status: :unprocessable_entity }
			end
		end
	end

	private
	def issueHistory_params
		params.require(:issue_history).permit(:member_id, :book_id, :issue_date, :return_date, :no_of_copies, :type_of_book)
	end
end
