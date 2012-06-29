class TemplatesController < ApplicationController
	def thumbnail
		experiment = Experiment.find(params[:id])
		send_data open(ENV["MICROARRAY_ANALYZER_PATH"] + 
									"input/templates/#{experiment.id}/#{File.basename(experiment.template.image_filename)}.thumbnail.png", "rb") { |f| f.read }		
	end
end
