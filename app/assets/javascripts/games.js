// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
this.App = {};

App.cable = ActionCable.createConsumer();

App.games = App.cable.subscriptions.create('GamesChannel', {  
  received: function(data) {
    var game_id = parseInt(document.getElementById("game_id").value)
    if(game_id == data.game_id){
      if(data.type == "message"){
        var board = document.getElementById("messages");
        var message = document.createElement("div");
        message.appendChild(document.createTextNode(data.user + ": " + data.content));
        board.appendChild(message); 
      } else {
        document.getElementsByClassName("audio")[data.height].play();
        setTimeout(function(){ document.location.reload(); }, 1000);
      }  
    }

  }
});