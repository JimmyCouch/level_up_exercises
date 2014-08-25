$(document).ready(function(){
    animateExplode();
    animatePic();
});

function makeNewPosition(){
    
    var h = $(window).height() - 50;
    var w = $(window).width() - 50;
    
    var nh = Math.floor(Math.random() * h);
    var nw = Math.floor(Math.random() * w);
    
    return [nh,nw];    
    
}

function animateExplode(){
    var newq = makeNewPosition();
    $('.explode').animate({ top: newq[0], left: newq[1] }, function(){
      animateExplode();        
    });
};

function animatePic() {
    var newq = makeNewPosition();
    $('.explode_pic').animate({ top: newq[0], left: newq[1] }, function(){
      animatePic();        
    });
}