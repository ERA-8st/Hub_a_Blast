$(function(){
  var loader = $('.loader-wrap');

  // ページ遷移が始まるとアニメーションを表示
  $(window).on('beforeunload',function(){
    loader.fadeIn();
  });

  //ページの読み込みが完了したらアニメーションを非表示
  $(window).on('load',function(){
    loader.fadeOut();
  });

  //ページの読み込みが完了してなくても3秒後にアニメーションを非表示にする
  setTimeout(function(){
    loader.fadeOut();
  },3000);

});