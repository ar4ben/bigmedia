var CKEDITOR_BASEPATH = '/assets/ckeditor/';

$(document).ready(function() {
    $('.prettyselect').each(function() {
      $(this).select2({ placeholder: 'Choose from list' });
    });
    $('.tagselect').each(function() {
        var placeholder = $(this).data('placeholder');
        var url = $(this).data('url');
        $(this).select2({
          tags: true,
          placeholder: placeholder,
          minimumInputLength: 1,
          ajax: {
            url: url,
            dataType: 'json',
            data: function(params) { return { q: params.term }; },
            processResults: function (data) {
              return {
                results: data
              };
            }
          }
        });
    });
    //hide sidebar after search 
    $('#search-status-_sidebar_section').click(function(event) {
      $(this).hide();
    });
});