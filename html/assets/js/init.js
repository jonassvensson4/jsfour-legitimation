$(document).ready(function(){
  // Client listener
  window.addEventListener('message', function(event) {
      if (event.data.action == 'open') {
        var data = event.data.array;
        $('#lastname').text(data.lastname);
        $('#firstname').text(data.firstname);
        $('#sex').text(data.sex.toUpperCase() + '/' + data.sex.toUpperCase());
        $('#height').text(data.height + ' CM');
        var pNumb =  data.dateofbirth.substring(2,4) + data.dateofbirth.substring(5,7) + data.dateofbirth.substring(8,10);
        $('#personnummer').text(pNumb + '-' + data.lastdigits);
        $('body').show();
      } else if (event.data.action == 'close') {
        $('body').hide();
      }
  });
});
