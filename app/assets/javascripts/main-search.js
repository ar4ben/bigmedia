$(function() { 
    $('.main-search').on('submit', function(e) {
        e.preventDefault();
        var data = $('#searchinput').val();
        window.open( "https://www.google.by/search?q=" + data + ' site:popnotdead.by');
    });
});