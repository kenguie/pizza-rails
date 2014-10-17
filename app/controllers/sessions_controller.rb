class SessionsController < ApplicationsController

	def new

	end

	def create
		# login = GlobalPhone.normalize(params(:email))
		# login = 

		@grubber = Grubber.find_by(email: params[:email]).first
			if @grubber && @grubber.password == params[:password]
				session[:grubber_id] = @grubber.id
				flash[:notice] = "You logged in Grubber!"
				redirect_to message_path
			else
				flash[:alert] = "Something went wrong."
				redirect_to root_path
			end
	end

	def destroy
		session[:grubber_id] = nil
		flash[:notice] = "You've logged out!"
		redirect_to root_path
	end

end