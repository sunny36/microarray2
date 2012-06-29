class Probe < ActiveRecord::Base
  set_primary_key :id
  belongs_to :experiment
  has_many   :testspots

  def thumbnail_filename
    filename_witout_extension = File.basename(self.filename).sub(".tif", "")
    "#{filename_witout_extension}_thumbnail.png"
  end

  def only_filename
    File.basename self.filename
  end
end
