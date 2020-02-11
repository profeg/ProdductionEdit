$(document).ready(function() {
  $( "#run-command" ).click(function() {
    $( "#run-command" ).prop( "disabled", true );
    $( "#run-command" ).html("Processing...");


    $("#command-line").val("");
    $("#command-line").height("24px");
    $("#command-output").val("");
    $("#command-output").height("24px");

    var environment = $("#environment-input").val();
    var project = $("#project-input").val();
    var command = $("#code-input").val();

    var data = {
      wait: $("#wait").prop("checked"),
      output: $("#output").prop("checked"),
      without_task_logs: $("#without-task-logs").prop("checked"),
      environment: environment,
      project: project,
      command: command
    };

    $.post( "/welcome", data, function( data ) {
      $( "#run-command" ).prop( "disabled", false );
      $( "#run-command" ).html("Run");

      $([document.documentElement, document.body]).animate({
        scrollTop: $("#command-output").offset().top
      }, 2000);

      $("#command-line").val(data.result);
      $("#command-line").height("100px");

      if(data.command_output) {
        $("#command-output").val(data.command_output);
        $("#command-output").height("500px");
      }
    });
  });

});
