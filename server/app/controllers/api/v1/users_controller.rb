module Api
	module V1
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
				if @user.save
					render json: { user: @user }, status: 201
				else
					render json: ":(", status: 422
				end
			end
			def update
				@user = User.find(params[:id])
				@user.update_attributes(family_id: params[:family_id])
				render json: @user
			end
			def show
				@user = User.find(params[:id])
				render json: @user, status: 200
			end
		end
	end
end