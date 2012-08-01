soundManager.setup({

  // location: path to SWF files, as needed (SWF file name is appended later.)

  url: '',

  // optional: version of SM2 flash audio API to use (8 or 9; default is 8 if omitted, OK for most use cases.)
  // flashVersion: 9,

  // use soundmanager2-nodebug-jsmin.js, or disable debug mode (enabled by default) after development/testing
  // debugMode: false,

  // good to go: the onready() callback

  onready: function() {

    // SM2 has started - now you can create and play sounds!

    var mySound = soundManager.createSound({
      id: 'aSound',
      url: 'foom_0.wav'
      // onload: function() { console.log('sound loaded!', this); }
      // other options here..
    });
  },
  mySound.play();
  // optional: ontimeout() callback for handling start-up failure

  ontimeout: function() {

    // Hrmm, SM2 could not start. Missing SWF? Flash blocked? Show an error, etc.?
    // See the flashblock demo when you want to start getting fancy.

  }

});
