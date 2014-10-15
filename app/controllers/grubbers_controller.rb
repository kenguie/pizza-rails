class GrubbersController < ApplicationController

	def message
		@message = params[:body]
		puts "*********** sending messages *************"
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
  		redirect_to root_path
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
