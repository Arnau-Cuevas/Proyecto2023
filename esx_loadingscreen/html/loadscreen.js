$(document).ready(function(){
    window.addEventListener('mousemove', function(e) {
		cursor.style.left = e.clientX + "px"; 
    	cursor.style.top = e.clientY + "px";
	});
    $('audio').prop("volume", 0.2);
    $('video').prop("volume", 0.2);
    $(".content-btn1").click(function(){
        $("#noticias-texto").fadeOut();
        $("#reglas-texto").fadeOut();
        $("#staff-texto").fadeOut();
    });
    $(".content-btn2").click(function(){
        $("#reglas-texto").fadeOut();
        $("#staff-texto").fadeOut();
        $('#noticias-texto').removeClass('hidden');
        $("#noticias-texto").fadeIn();
    });
    $(".content-btn3").click(function(){
        $("#noticias-texto").fadeOut();
        $("#staff-texto").fadeOut();
        $('#reglas-texto').removeClass('hidden');
        $("#reglas-texto").fadeIn();
    });
    $(".content-btn4").click(function(){
        $("#noticias-texto").fadeOut();
        $("#reglas-texto").fadeOut();
        $('#staff-texto').removeClass('hidden');
        $("#staff-texto").fadeIn();
    });
});
