class UsersController < ApplicationController
  skip_before_action :require_login, except: [:create]

  def index
  	return render '/users/index'
  end

  def new
  end

  def create
  	user = User.new(user_params)
  	if user.save
  		redirect_to "/"
  	else
  		flash[:errors] = user.errors.full_messages
  		redirect_to "/"
  	end
  end

  def show
  	@user = User.find(session[:user_id])
  	@events = Event.all
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	user = User.find(params[:id])
  	user.update(user_params)

  	if user.save
  		redirect_to "/users/#{user.id}/edit"
  	else
  		flash[:errors] = user.errors.full_messages
  		redirect_to "/users/#{user.id}/edit"
  	end
  end

  private 
  	def user_params
  		params.require(:user).permit(:first_name, :last_name, :email, :location, :state, :password, :password_confirmation)
  	end

  	def auth
  		return redirect_to "/users/#{current_user}" unless current_user.id == params[:id].to_i
  	end
end
