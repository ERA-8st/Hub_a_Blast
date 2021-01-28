$(function(){
  $(".comment_pulldown").hover(function(){
      $("li:not(:animated)", this).slideDown();
  }, function(){
      $("li",this).slideUp();
  });
});