class Experiment < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessor :zip_file
  belongs_to :template
  has_many   :probes

  def name
  	"#{self.id}, #{self.comments}"
  end
end
