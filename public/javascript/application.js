$(document).ready(function() {

    // create a drawing area inside an element
    var canvas = new drawingCanvas($('#draw'));
    // alert("test");
    // log the drawn image's data when button is clicked
    $('#save').submit(function(e) {
        var imagedata = canvas.getImage();
        $('#image_data').val(imagedata);
    });
    
});

$(document).ready(function() {
  $('.alert').delay(2000).fadeIn(300);

  $('.fa-times-circle').click(function(){
   $(this).parent('.alert').fadeOut(300);
  });

  $('.switch').click(function(){
     $(this).children('i').toggleClass('fa-pencil');
     $('.login').animate({height: "toggle", opacity: "toggle"}, "slow");
     $('.register').animate({height: "toggle", opacity: "toggle"}, "slow");
  });
  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()
});

$(document).ready(function() {
    $('.bottom .new_story').click(function() {
        $(".bottom #draw").addClass("show");
    });
});
