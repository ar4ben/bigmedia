$(function() {
  var ic = $('.image-container').width();
  var tc = $('.text-container').width();
  var reduction = 0.6
  $('.image-container').css({'height':(ic * 1.5)+'px'});
  $('.big-image-container').css({'height':(ic * 1.5)+'px'});
  $('.text-container').css({'height':(tc * reduction) +'px'});
  $('.big-text').css({'height':(ic * 1.5)+'px'});
  $('<style>.text-container-bottom:before{content:"";width:100%;height:100%;position:absolute;left:0;top:0;background:linear-gradient(rgba(255,255,255,0) ' + ((tc * reduction)-20) + 'px,pink);}</style>').appendTo('.text-container-bottom');
  $('<style>.text-container-top:before{content:"";width:100%;height:100%;position:absolute;left:0;top:0;background:linear-gradient(rgba(255,255,255,0) ' + ((tc * reduction)-20) + 'px,darkgrey);}</style>').appendTo('.text-container-top');
});