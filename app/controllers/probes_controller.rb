class ProbesController < ApplicationController
  respond_to :html, :json
  def show
    @probe = Probe.find(params[:id])
    gon.probe = @probe
    respond_with(@probe)
  end

	def thumbnail
		probe = Probe.find(params[:id])
		send_data open(ENV["MICROARRAY_ANALYZER_PATH"] + "input/#{probe.experiment.id}/#{File.basename(probe.filename)}.thumbnail.png", "rb") { |f| f.read }
	end
	
	def image
		probe = Probe.find(params[:id])
		send_data open(ENV["MICROARRAY_ANALYZER_PATH"] + "input/#{probe.experiment.id}/#{File.basename(probe.filename)}.png", "rb") { |f| f.read },
							:type => "image/png"
	end
end
