class GrubbersController < ApplicationController

	def message
		require 'mandrill'
		@message = params[:body]
		puts "*********** sending messages *************"

		#Grubber.email_grubbers(message)

		Grubber.emailable.each do |grubber|
			grubber.send_email(message)
		end

		redirect_to message_grubbers_path
	end

  def index
  end

  def show
  end

  def new
  	@grubber = Grubber.new
  end

  def create
  	@grubber = Grubber.new(user_params)

  	# configure_new_grubber sets attributes in the grubber model
  	if @grubber.save
  		flash[:notice] = "Let's get grubbing"
  		redirect_to grubber_path(@grubber.id)
  	else
  		flash[:alert] = "Something went wrong"
  		render :new
  	end
  end

  def edit
  end

  private

  def user_params
  	params.require(:grubber).permit(:mobile, :email, :password)
  end






end
