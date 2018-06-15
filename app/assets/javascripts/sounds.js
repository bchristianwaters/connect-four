function getUrlParam(name) {
    var results = new RegExp('[\\?&]' + name + '=([^&#]*)').exec(window.location.href);
    return (results && results[1]) || undefined;
}
window.onload = function(){
    var height = getUrlParam('height');
    if (height > "") {
        document.getElementsByClassName("audio")[Number(height)].play();
        Number(height)
    } else {
    }    
}