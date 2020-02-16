import CodeMirror from "codemirror";

$(document).ready(function() {
  var codeInputElement = $("#code-input")[0];
  var myCodeMirror = CodeMirror.fromTextArea(codeInputElement, {
    lineNumbers: true,
    mode: "text/x-ruby",
    tabSize: 2
  });

  myCodeMirror.setValue(window.commands);

  window.myCodeMirror = myCodeMirror;
});
