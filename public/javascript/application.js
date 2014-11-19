$(document).ready(function() {

    // create a drawing area inside an element
    var canvas = new drawingCanvas($('#draw'));

    // log the drawn image's data when button is clicked
    $('#save').click(function(e) {
        var imagedata = canvas.getImage();
        console.log(imagedata);
    });
    
});