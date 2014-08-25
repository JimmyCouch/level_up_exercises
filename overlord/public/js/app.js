$(function () {

	$('.header-alert').delay(500).fadeIn('normal', function() {
	    $(this).delay(2500).fadeOut();
	});


	// var img = document.getElementById('battery');
	var img = document.createElement('IMG');
	img.src="/img/battery.jpg"

	var c = document.getElementById("myCanvas");
	var ctx = c.getContext("2d");
	ctx.drawImage(img,75,60);

	var x = img.naturalHeight;
	var y = img.naturalWidth;

	var newy = (0.5*x) + (c.height - img.height);
	var newx = (0.5*y) + (c.width / 2);

	ctx.beginPath();
	ctx.moveTo(newx,newy);
	ctx.lineTo(newx+50,newy);
	ctx.strokeStyle="#000000";
	ctx.lineWidth=5;
	ctx.stroke();

	var secondLineX = newx + 50;
	ctx.beginPath();
	ctx.moveTo(secondLineX,newy);
	ctx.lineTo(secondLineX,0);
	ctx.stroke();

	var newy = (0.5*x) + (c.height - img.height)
	var newx = (c.width / 2) - (0.5*y) 

	ctx.beginPath();
	ctx.moveTo(newx,newy);
	ctx.lineTo(newx-50,newy);
	ctx.strokeStyle="#ff0000";
	ctx.stroke();

	var secondLineX = newx - 50;

	ctx.beginPath();
	ctx.moveTo(secondLineX,newy);
	ctx.lineTo(secondLineX,0);
	ctx.stroke();


	var time = parseInt($("#hidden-timer").text());
	console.log("TIME: "+time)
	var d = new Date();
	var bombTimer = new Date(d.getTime() + time);


	$("#bomb-timer").countdown(bombTimer, function(event) {
		$(this).text(event.strftime('%M:%S'));
	}).on('finish.countdown', function(event) {
  		window.location.replace("/explode");
	});

	$("#bomb-deactivate").click(function(e){
		$("#form-timer").val($("#bomb-timer").text())
	})

});



    