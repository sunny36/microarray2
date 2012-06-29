Experiment = { };

Experiment.init = function () {
  $("select#experiments").change(function() {
    window.location.href = '/experiments/' + $(this).val();
  });
  
  
  var image = {};
  var circles = {};
  var paper = {};  
  if ($("#template_image").length > 0) {
    paper["template_image"] = Raphael("template_image", 
                                      gon.template.width, 
                                      gon.template.height);
    image["template_image"] = paper["template_image"].image(
      "/templates/" + gon.template.id + "/thumbnail", 0, 0, 
      gon.template.width, gon.template.height);
    circles["template_image"] = [];
    if (gon.template.template_control_points.length == 3) {
      $.each(gon.template.template_control_points, function (index, value) {
        paper["template_image"].circle(value.x, value.y, 3)
                               .attr({stroke: "red", 
                                      "stroke-width": 3, 
                                      "stroke-opacity": 0.5});
        circles["template_image"].push([value.x, value.y]);        
      })
    }
    image["template_image"].click(function (event) {
      if (circles["template_image"].length >= 3) {
        alert("You have already select 3 points");
      } else {
        posx = event.pageX - $(document).scrollLeft() - $('#template_image').offset().left;
        posy = event.pageY - $(document).scrollTop() - $('#template_image').offset().top;    
        paper["template_image"].circle(posx, posy, 3)
                               .attr({stroke: "red", "stroke-width": 3, "stroke-opacity": 0.5});
        circles["template_image"].push([posx, posy]);  
        $.post("/template_control_points", { template_id: gon.template.id, x: posx, y: posy } );    
      }    
    });    
  }
  
  if ($('.probe_modal').length > 0) {
    $.each($('.probe_modal'), function (index, value) {
      var canvasId = $(value).children('.modal-body').children('div').attr("id");
      var probeId = canvasId.split("_")[1];
      var probe;
      $.each(gon.probes, function(index, value) {
        if (probeId == value.id) {
          probe = value;
        }
      });
      paper[canvasId] = Raphael(canvasId, probe.width, probe.height);
      image[canvasId] = paper[canvasId].image("/probes/" + probe.id + "/image", 0, 0, probe.width, probe.height);
      circles[canvasId] = [];        
      image[canvasId].click(function (event) {
        if (circles[canvasId].length >= 3) {
          alert("You have already select 3 points");
        } else {
          posx = event.pageX - $(document).scrollLeft() - $('#' + canvasId).offset().left;
          posy = event.pageY - $(document).scrollTop() - $('#' + canvasId).offset().top;    
          paper[canvasId].circle(posx, posy, 3).attr({stroke: "red", "stroke-width": 3, "stroke-opacity": 0.5});
          circles[canvasId].push([posx, posy]);      
        }    
      });          
    });    
  }

  $('.probe_thumbnail').click(function () {
    alert('Please select the control point for the template image');
    return false;
  });
  
}
