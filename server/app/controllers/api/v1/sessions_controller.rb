module Api
	module V1
		class SessionsController < ApplicationController
			def create
				email = params[:email]
				password = params[:password]
				device_token = params[:device_token] # for push notifications to devices
				device_type = params[:device_type] # to know what notification to send
				user = User.find_by(email: email)
				if user && user.authenticate(password)
					render json: user
				else
					self.headers['WWW-Authenticate'] = 'Token realm="Application"'
					render json: 'Bad credentials', status: 401
				end
			end
		end
	end
end