class GrubbersController < ApplicationController

	def message
		@message = params[:body]
		puts "*********** sending messages *************"
			# m = Mandrill::API.new
			# message = {
			# :subject=> "Grub Alert",
			# :from_name=> "Grub Tracker",
			# :text=>"Pizza's here!",
			# :to=>[
			# {
			# :email=> "kenrickguie@gmail.com",
			# :name=> "Ken"
			# }
			# ],
			# :html=>"<html><h1>Hi <strong>Pizza is here!</strong>, come now!</h1></html>",
			# :from_email=>"nyhunter77@gmail.com"
			# }
			# sending = m.messages.send message
			# puts sending

			require 'mandrill'

			# send a new message
			m = Mandrill::API.new
			message = { 
			:subject=> "Pizza's here!", 
			:from_name=> "Pizza Alert",
			:from_email=>"kenrickguie@gmail.com",
			:to=>"nyhunter77@gmail.com", 
			:html=>"Pizza's here!", 
			:merge_vars => "Pizza is here!",
			:preserve_recipients => false
			} 
			sending = m.messages.send message
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
