class ProbesController < ApplicationController
  respond_to :html, :json
  def show
    @probe = Probe.find(params[:id])
    gon.probe = @probe
    respond_with(@probe)
  end
end
