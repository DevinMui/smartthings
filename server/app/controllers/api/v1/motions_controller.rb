module Api
	module V1
		class MotionsController < ApplicationController
			def index
				@motion = Motion.last
				render json: @motion
			end
			def create
				@motion = Motion.create(motion: true)
				render json: @motion
			end
			def show
				@user = User.find_by_email(params[:email])
				@motion = Motion.find(params[:id])
				@motion.update_attributes(user_id: @user.id, motion: false)
				render json: @motion
			end
		end
	end
end
