function getUrlParam(name) {
    var results = new RegExp('[\\?&]' + name + '=([^&#]*)').exec(window.location.href);
    return (results && results[1]) || undefined;
}
window.onload = function(){
    var height = getUrlParam('height');
    var type = getUrlParam('type');
    if (height > "") {
        document.getElementsByClassName("audio")[Number(height)].play();
        if (type == "medium" || type == "easy" || type == "difficult") {
            document.getElementsByClassName("audio")[Number(height)+6].play();
        }
    }  
}