class TemplateControlPointsController < ApplicationController
	respond_to :html, :json
	def create
		template_control_point = TemplateControlPoint.new(template_id: params[:template_id], x: params[:y], y: params[:y])
		template_control_point.save
		respond_with(template_control_point)
	end
end