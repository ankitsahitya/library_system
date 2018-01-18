class MembersController < ApplicationController
	skip_before_action :verify_authenticity_token
	def new
		@member = Member.new
		respond_to do |format|
			format.json { render json: {member: @member}, status: :ok }
		end
	end

	def show
		begin
			@member = Member.find(params[:id])
			respond_to do |format|
				format.json { render json: {member:@member}, status: :ok }
			end
		rescue ActiveRecord::RecordNotFound => e
			respond_to do |format|
				format.json { render json: {error:e.message}, status: :not_found}
			end
		end
	end

	def create
		begin
			@member = Member.new(member_params)
			respond_to do |format|
				if @member.save
					format.json { render json: { member: @member}, status: :created }
				else
					format.json { render json: @member.errors, status: :unprocessable_entity }
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
			@member = Member.find(params[:id])
			respond_to do |format|
				@member.destroy
				format.json { render json: {}, status: :ok }
			end  
		rescue ActiveRecord::RecordNotFound => e
			respond_to do |format|
				format.json { render json: {error:e.message}, status: :unprocessable_entity }
			end
		end
	end

	def index
		@members = Member.all
		respond_to do |format|
			format.json { render json: {members:@members}, status: :ok }
		end
	end

	def edit
		begin
			@member = Member.find(params[:id])
			respond_to do |format|
				format.json { render json: {member:@member}, status: :ok }
			end
		rescue ActiveRecord::RecordNotFound => e
			respond_to do |format|
				format.json { render json: {error:e.message}, status: :not_found }
			end
		end
	end

	def update
		begin
			@member = Member.find(params[:id])
			respond_to do |format|
				if @member.update(member_params)
					format.json { render json: {member:@member}, status: :ok }
				else
					format.json { render json: @member.errors, status: :unprocessable_entity }
				end
			end
		rescue => e
			respond_to do |format|
				format.json { render json: {error:e.message}, status: :unprocessable_entity }
			end
		end
	end

	private
	def member_params
		params.require(:member).permit(:name, :address, :phone_no, :gender, :code, :validity_date, :is_author, :library_id)
	end
end