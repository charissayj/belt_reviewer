class EventsController < ApplicationController

	def create
		user = User.find(session[:user_id])
		event = Event.new(event_params)
		event.user = user

		if event.save
			session[:event_id] = event.id
			redirect_to '/events'
		else
			flash[:errors] = event.errors.full_messages
			redirect_to '/events'
		end
	end

	def show
		@event = Event.find(params[:id])
		@events = Event.all
		@comments = Comment.all
	end

	def edit
  		@event = Event.find(params[:id])
  	end

  	def update
	  	event = Event.find(params[:id])
	  	event.update(event_params)

	  	if event.save
	  		redirect_to "/events"
	  	else
	  		flash[:errors] = user.errors.full_messages
	  		redirect_to :back
	  	end
  	end

	def destroy
	  	Event.find(params[:id]).destroy
	  	redirect_to :back
	end

	def event_params
		params.require(:event).permit(:name, :date, :location, :state)
	end
end
