class Grubber < ActiveRecord::Base
	scope :subscribed, ->{where(subscribed: true) } 

	scope :emailable, ->{where(email_ok: true, subscribed: true)}
	scope :textable , ->{subscribed.where(text_ok: true)}
# wow Jason - sql?
	scope :find_grubber ->(params_key) {where'(email = ? or mobile = ?'), "#{params_key}", "#{params_key}" }

	validates :password, presence: true
	validates :email, uniqueness: true
	validates :mobile, uniqueness: true
#try this out! Franky
	validates :email, presence: { 
		message: "Must provide email or mobile number.",
			unless: Proc.new {|grubber| grubber.mobile.present?} }			
	validates :email, uniqueness: true
	validates :mobile, presence: {
		message: "Must provide email or mobile number." 
			unless: Proc.new {|grubber| grubber.email.present?} }
	validates :mobile, uniqueness: true

	# def either_email_or_mobile_present
	# 	if email.present?
	# end


	before_create :configure_new_grubber
	#before_validation :normalize_mobile

	# def normalize_mobile
	# 	self.mobile = GlobalPhone.noramlize(self.mobile)
	# end

	def configure_new_grubber
		self.subscribed = true
  		if self.mobile.present? 
  			self.text_ok = true
  		end

  		if self.email.present?
  			self.email_ok = true
  		end
	end 

	# def send_text(message_body)
	# 	# Get your Account Sid and Auth Token from twilio.com/user/account
	# 	# account_sid = ENV['???']
	# 	# auth_token = ENV['???']
	# 	# grubber_system_number = ENV['???']  Moved to initializers
		
	# 	# @client = Twilio::REST::Client.new account_sid, auth_token
	# 	@client = Twilio::REST::Client.new ENV['???'], ENV['???']  #grabbed from twilio initializer
 # 		mobile = self.mobile

	# 	#testing
	# 	puts "*" * 40
	# 	puts "mobile: #{mobile}"
	# 	puts "message: #{message_body}"


	# 	message = @client.account.messages.create(:body => message_body,
 #    		:to => mobile,
 #    		:from => grubber_system_number
	# 	puts message.to

	# end

	# def self.text_grubbers(message_body)
	# 	Grubber.textable.each do |grubber|
	# 		grubber.send_text(message_body)
	# 	end
	# end



	# def send_email(message_body) #instance method

	# 		recipient = [{email: self.email}]
	# 		m = Mandrill::API.new
	# 		message = {
	# 		:subject=> "Grub Alert",
	# 		:from_name=> "Grub Tracker",
	# 		:text=> message_body,
	# 		:to=>[ #emailable_grubbers          #recipient - for class method 
	# 		{  
	# 		:email=> "kenrickguie@gmail.com",
	# 		# :name=> "Ken"
	# 		}
	# 		],
	# 		:html=>"<html><h1>Hi <strong>#{message_body}</strong>, come now!</h1></html>",
	# 		:from_email=>"nyhunter77@gmail.com"
	# 		}
	# 		sending = m.messages.send message
	# 		puts sending

	# end  # gotta go over the instance method again ####################

	# 	def self.email_grubbers(message_body)  # instance is better(not self) - one email at a time to 1 recipient 
	# 	# m = Mandrill::API.new

	# 	Grubber.emailable.each do |grubber|
	# 		grubber.send_email(message_body)  
	# 	end
	# end

	def self.email_grubbers(message_body)  # this is class method - not a good idea, instance is better(not self) - one email at a time to 1 recipient 
		 m = Mandrill::API.new

		emailable_grubbers = Grubber.emailable.map do |grubber|  
			Hash(email: grubber.email) 
		end

		emailable_grubbers.each do |email|
			recipient = [email]
			#m = Mandrill::API.new
			message = {
			:subject=> "Grub Alert",
			:from_name=> "Grub Tracker",
			:text=> message_body,
			:to=>[ #emailable_grubbers          #recipient - for class method 
			{  
			:email=> "kenrickguie@gmail.com",
			# :name=> "Ken"
			}
			],
			:html=>"<html><h1>Hi <strong>#{message_body}</strong>, come now!</h1></html>",
			:from_email=>"nyhunter77@gmail.com"
			}
			sending = m.messages.send message
			puts sending

		end
	end
end
