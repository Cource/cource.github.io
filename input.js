var vue;

vue = new Vue({
  el: '#input',
  data: {
    saleId: 0,
    input: '',
    sum: 0,
    distributors: ['Milk', 'KA(vegetables)', 'hanashi', 'bashou', 'nandesu'],
    distName: ''
  },
  methods: {
    insert: function(num) {
      this.input += num;
    },
    rmnum: function() {
      this.input = this.input.slice(0, this.input.length - 1);
    },
    pushToQueue: function() {
      $('#history').html($('#history').html() + '<p>' + this.input + '</p>');
      this.sum += eval(this.input);
      this.input = '';
    },
    boom: function() {
      this.input = '';
      this.sum = 0;
      $('#history').html('');
    },
    sell: function() {
      if (this.input !== '' || this.sum) {
        if (this.input !== '') {
          this.pushToQueue();
        }
        eel.postSale(JSON.stringify({
          id: this.saleId,
          amt: this.sum,
          time: new Date()
        })).then(vue.boom(), this.saleId++);
      }
    },
    showTxt: function() {
      $('#add').hide();
      return $('#txt>input').show();
    },
    addDist: function() {
      this.distName = '';
      $('#txt>input').hide();
      return $('#add').show();
    },
    purchase: function(distributor) {
      return console.log(distributor);
    }
  }
});

$.getJSON('db/sale.json', function(data) {
  vue.saleId = data[data.length - 1].id + 1;
});

$('#close').click(function() {
  $('#distributor').animate({
    bottom: '-70vh'
  }, 400, 'swing');
});

$('#purchase').click(function() {
  $('#distributor').animate({
    bottom: 0
  }, 400, 'swing');
});
