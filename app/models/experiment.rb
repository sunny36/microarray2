class Experiment < ActiveRecord::Base
  attr_accessor :zip_file
  belongs_to :template
  has_many   :probes

	before_create do
		self.system_input_folder  = "../input/" 
    self.system_output_folder = "../output/"
		self.probe_folder_name = ""
		self.probe_image_wildcard = "*.tif"
	end
	
	after_create do
		self.probe_folder_name = "../input/#{self.id}"
    self.save
	end
	
  def name
  	"#{self.id}, #{self.comments}"
  end
end
