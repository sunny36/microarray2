class TestspotsController < ApplicationController
  respond_to :html, :json

  def show
    @testspot = Testspot.find(params[:id])
    respond_with(@testspot)
  end
end
