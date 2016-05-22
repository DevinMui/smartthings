module Api
	module V1
		class FamiliesController < ApplicationController
			def index
				@families = Family.all
				render json: @families, status: 200
			end
			def create
				@family = Family.create(name: params[:name], address: params[:address])
				render json: @family, status: 200
			end
			def show
				@family = Family.find(params[:id])
				render json: @family, status: 200
			end
		end
	end
end
