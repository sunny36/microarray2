class Template < ActiveRecord::Base
  has_many :experiments

	def template_control_points
		TemplateControlPoint.where(template_id: self.id)
	end
end
