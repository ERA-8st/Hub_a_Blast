var lastScrollTop = 0;

$(window).scroll(function(event){
  _header = $('.user-header');
  if ($(this).scrollTop() > lastScrollTop){
    _header.slideUp("fast");
  } else {
    _header.slideDown("fast");
  }

  lastScrollTop = $(this).scrollTop();
});