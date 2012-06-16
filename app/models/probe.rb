class Probe < ActiveRecord::Base
  set_primary_key :id
  belongs_to :experiment
  has_many   :testspots

  def thumbnail_filename
    filename_witout_extension = self.filename.sub(".tif", "")
    "#{filename_witout_extension}_thumbnail.png"
  end
end
