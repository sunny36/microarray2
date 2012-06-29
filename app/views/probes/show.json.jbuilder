json.(@probe, :id, :experiment_id, :filename, :width, :height, :comments, :only_filename)

json.testspots @probe.testspots do |json, testspot|
  json.(testspot, 
        :id, :rect_x, :rect_y, :rect_width, :rect_height, :circle_detected, 
        :circle_x, :circle_y, :circle_radius, :mean, :std_dev, :min, :max,
        :median, :comments)
end
