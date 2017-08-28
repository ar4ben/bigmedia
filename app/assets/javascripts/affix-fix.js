$(function() {
    var $affixElement = $('div[data-spy="affix"]');
    $affixElement.width($affixElement.parent().width());

    $('div[data-spy="affix"]').affix({
      offset: {
        top: function() { return ( $('.top-block').outerHeight() - 10); }
      }
    });

});