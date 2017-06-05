$(document).ready(function() {
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
});