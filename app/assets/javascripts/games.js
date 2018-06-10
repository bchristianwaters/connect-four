// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
this.App = {};

App.cable = ActionCable.createConsumer();

App.games = App.cable.subscriptions.create('GamesChannel', {  
  received: function(data) {
    location.reload();;
  }
});