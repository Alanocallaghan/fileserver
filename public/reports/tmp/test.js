$(function(){
    $.ajax({
        type: "GET",
        url: 'test.php',
        success: function(data){
            document.body.append(data)
        }
    });
});
