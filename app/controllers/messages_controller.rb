class MessagesController < ApplicationController
	def new
	end
	
	def create
		
		@message = Message.new( :body=>params[:message][:body], 
										:user_id => current_user, 
										:household_id => current_user.household )	
		@message.save
		
		render plain: params[:article].inspect
		
	end
	
end
