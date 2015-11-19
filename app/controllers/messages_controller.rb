class MessagesController < ApplicationController
	def new
	end
	
	def create
		
		@chore_name = params[:message][:body]
		
		@text = current_user.name + " claims to have completed the chore '" + @chore_name + "'. Did they?"
		
	
		
		@message = Message.new( :body => @text)
		@message.user_id = current_user.id
		@message.household_id = current_user.household.id
		
		@message.save
		
		
		redirect_to "/home/index"
		
	end
	
end
