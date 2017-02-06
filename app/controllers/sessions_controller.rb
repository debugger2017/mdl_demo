class SessionsController < ApplicationController

	def new 
	end

	def create
		user = User.find_by(email: params[:session][:email])
		tmp = User.select(:password).where(email: user.email).first
		if user && user.password == tmp['password']
			log_in user
			redirect_to user
		else
			render 'new'
        	
        end 
	end

	def destroy
    	log_out
    	redirect_to root_url
 	end
end
