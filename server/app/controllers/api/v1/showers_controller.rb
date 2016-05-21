module Api
	module V1
		class ShowersController < ApplicationController
			# should rename shower to water
			def time_stamp_start
				@shower = Shower.create(user_id: params[:user_id], time_start: Time.now)
				render json: @shower, status: 200
			end

			def time_stamp_end
				@shower = Shower.find(params[:id])
				@shower.update_attributes(time_stop: Time.now)
				@total_time = (@shower.time_stop - @shower.time_start) / 60 # returns time difference in minutes
				@shower.update_attributes(time_total: @total_time)
				render json: @shower, status: 200
			end
		end
	end
end