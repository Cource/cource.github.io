$('.imag').css({
  backgroundSize: 'contain',
  backgroundRepeat: 'no-repeat',
  backgroundPosition: 'center'
});

$('#sale').css({
  background: '#CFDEDF'
});

new Vue({
  el: '#app',
  methods: {
    changeScreen: function(screen) {
      $('#' + screen).css({
        background: '#CFDEDF'
      });
      return $('.top > :not(#' + screen + ')').css({
        background: 'none'
      });
    }
  }
});
