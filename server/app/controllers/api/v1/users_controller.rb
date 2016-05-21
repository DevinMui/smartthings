module V1
	module Api
		class UsersController < ApplicationController
			def index
						# probably better to paginate this but do it later
				@users = User.all
				render json: @users, status: 200
			end
			def create
				@user = User.new(name: params[:name],
					email: params[:email],
					password: params[:password])

				@user.owner = false
				if @user.save
					render json: { user: @user, "auth_key": @user.auth_key }, status: 201
				else
					render json: ":(", status: 422
				end
			end
			def show
				@user = User.find(params[:id])
				render json: @user, status: 200
			end
		end
	end
end