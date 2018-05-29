$(function(){
    $.ajax({
        type: "GET",
        url: 'test.php',
        success: function(data){
        	$("body").append("<b>" + data + "</b>")
        }
    });
});
