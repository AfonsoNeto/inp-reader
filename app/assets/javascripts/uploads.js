var Upload = (function($){
  var _formSelector = "form#upload_inp_files_form";
  var _recipientFieldSelector = "input#recipient_email_field";

  function _init() {
    Dropzone.autoDiscover = false;

    $(_formSelector).dropzone({
      paramName: "upload[file]",
      success: _persistEmail
    });
  }

  function _persistEmail(file, response) {
    var _updateUrl = '/uploads/' + response.fileId + '.json';
    var _recipientField = $(_formSelector + ' ' + _recipientFieldSelector);
    var _recipientEmail = _recipientField.val();

    if (_recipientEmail == undefined || _recipientEmail == '') {
      alert("As you haven't specified any e-mail address, the results will be sent to the default `to@example.com`");
      _recipientEmail = 'to@example.com';
    }

    $.ajax({
      url: _updateUrl,
      method: 'patch',
      data: {
        upload: {recipient: _recipientEmail}
      }
    }).success(function() {
      alert("You file is being processed and the results will be sent to `" + _recipientEmail + "`!");

    }).error(function() {
      alert('Ooops... something went wrong!');
    });
  }

  return { init: _init }
}($));