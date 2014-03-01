MessageBus.start(); // call once at startup

// how often do you want the callback to fire in ms
MessageBus.callbackInterval = 500;
MessageBus.subscribe("/channel", function(data){

  json = JSON.parse(data)
  if(json.event == 'song_change'){
    row = $.find("[data-song-id='" + json.id + "']");
    $('.playlist-row').removeClass('active');
    $(row).addClass('active');
    $('#now-playing').html(json.artist + ' - ' + json.title);
  }
  else {
    console.log('Unknown event: ' + json);
  }


});
