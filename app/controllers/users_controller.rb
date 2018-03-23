class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @user = User.find_or_create_from_auth_hash(auth_hash)
    session[:user] = @user
    respond_to do |format|
      if @user.save
        format.json { render json: { user: @user}, status: :created }
        format.html { redirect_to "/libraries" }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
        format.html { render html: @user.errors }
      end
    end
  end

  def logout
    reset_session
    redirect_to "/libraries"
  end
  private

  def auth_hash
    request.env['omniauth.auth']
  end
end