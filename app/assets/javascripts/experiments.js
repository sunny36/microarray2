Experiment = { };

Experiment.init = function () {
  $("select#experiments").change(function() {
    window.location.href = '/experiments/' + $(this).val();
  });
}
