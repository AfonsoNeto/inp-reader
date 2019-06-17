var Upload = (function($){
  var _formSelector = "form#upload_inp_files_form";

  function _init() {
    Dropzone.autoDiscover = false;

    $(_formSelector).dropzone({
      paramName: "upload[file]",
      success: function(file, response){
        console.dir(file);
        console.dir(response);
        // alert('Your file is being processed...');
      }
    });
  }

  return { init: _init }
}($));