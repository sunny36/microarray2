$(function(){
  $.getJSON($.url().attr('path'), function(probe){
      var paper = Raphael(probe.only_filename.split(".")[0], probe.width, probe.height);
      var img = paper.image("/probes/" + probe.id + "/image", 0, 0, probe.width, probe.height);
      var rectangles = [];
      var i = 0;
      _.each(probe.testspots, function(testspot) {
        rectangle = paper.rect(testspot.rect_x,
                               testspot.rect_y,
                               testspot.rect_width,
                               testspot.rect_height)
                         .attr({'stroke':     'red',
                               'stroke-width': 0.5,
                               'fill':         "red",
                               'fill-opacity': 00});
        rectangle.testspot_id = testspot.id;
        rectangles[i] = {'testspot_id': testspot.id, 'rectangle': rectangle};
        rectangles[i].rectangle.click(function (event) {
          setAllTestspotRowToWhite(probe.id);
          setSelectedTestspotRowToYellow(testspot.id);
          setAllRectangleToRed(rectangles);
          this.attr({stroke: 'yellow'});
          this.toFront();
          loadTestSpotData(this.testspot_id);
        });
        i = i + 1;

      });
  });

  function setAllRectangleToRed(rectangles) {
    _.each(rectangles, function(rectangle) {
      rectangle.rectangle.attr({stroke: 'red'});
    });
    return;
  }

  function loadTestSpotData(id) {
    $.getJSON('/testspots/' + id, function(data) {
      var testspot = data;
      $('#rect_x td').last().text(testspot.rect_x);
      $('#rect_y td').last().text(testspot.rect_y);
      $('#mean td').last().text(testspot.mean);
      $('#std_dev td').last().text(testspot.std_dev);
      $('#max td').last().text(testspot.max);
      $('#min td').last().text(testspot.min);
      $('#median td').last().text(testspot.median);
    });
  }

  function setAllTestspotRowToWhite(id) {
    $('table#probe' + id + ' tbody tr').css('background-color','white')
  }

  function setSelectedTestspotRowToYellow(id) {
    $('tr#testspot_' + id).first().css('background-color','yellow')
  }

});
