class GrubbersController < ApplicationController

	before_action :set_grubber

	def message
		#require 'mandrill'
		@message = params[:body]
		puts "*********** sending messages *************"

		Grubber.email_grubbers(message)

		#  ?????
		# Grubber.emailable.each do |grubber|
		# 	grubber.send_email(message)
		# end

		# Grubber.text_grubbers(message)

		# redirect_to message_grubbers_path
	end



  def sent 

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
  		redirect_to message_path
  	else
  		flash[:alert] = "Something went wrong"
  		render :new
  	end
  end

  def edit
  	
  end

  def update
  	if @grubber.update(grubber_params)
  		flash[:notice] = "Grubber successfully updated!"
  		redirect_to root_path
  	else
  		flash[:alert] = "Something went wrong with update!"
  		render :edit
  	end
  end

  private

  def user_params
  	params.require(:grubber).permit(:mobile, :email, :password, :email_ok, :text_ok, :subcribed)
  end

  def set_grubber
  	@grubber = Grubber.find(params[:id])
  end






end
