module ApplicationHelper
  
  def initialize_javascripts
    controller_name = controller.controller_name.classify
    javascript_tag <<-SCRIPT
      $(document).ready(function() {
        if(typeof #{controller_name} !== 'undefined'){
         #{controller_name}.init();
        }
      });
    SCRIPT
  end

end
