module Api
	module V1
		class ShowersController < ApplicationController
			# should rename shower to water
			def index
				@family = User.find(params[:id]).family
				@showers = @family.users.collect do |user|
					user.showers
				end
				@showers.sort {|a,b| b.updated_at > a.updated_at}
				#@showers = Shower.all
				render json: @showers, status: 200
			end
			def time_stamp_start
				@shower = Shower.create(user_id: params[:user_id], time_start: Time.now)
				render json: @shower, status: 200
			end

			def time_stamp_end
				@shower = Shower.find(params[:id])
				@shower.update_attributes(time_stop: Time.now)
				@total_time = (@shower.time_stop - @shower.time_start) # returns time difference in seconds
				@shower.update_attributes(time_total: @total_time)
				render json: @shower, status: 200
			end
		end
	end
end