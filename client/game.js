define(function () {
  var imageCache = {};
  var canvas;
  var context;
  var loader;

  function init(){
    canvas = document.getElementById("myCanvas");
    context = canvas.getContext("2d");
    drawLayers();
  }
  
  function drawLayer(a) {

    var size = Level.tilesets[0].tileheight;
    var border = 0;
    var imageObj = loader.loadImage(Level.tilesets[0].image);

    if (imageObj !== null) {
      var TilesX = imageObj.width/size;

      for (var y = 0; y < 32; y++) {
          for (var x = 0; x < 32; x++) {
              var index = Level.layers[a].data[x+y*size];

              if ( index > 0 ){//if null, don't draw a tile
                var srcx = ((index-1)%TilesX)*size;
                var srcy = Math.floor((index-1)/TilesX)*size;

                context.drawImage(imageObj, srcx, srcy, size, size, x * size, y * size, size, size);
              } //end if
          }
      }
    }
  }

  function drawLayers(){
    for (var i = 0; i < Level.layers.length; i++){
      drawLayer(i);
    }
  }

  function linearizeData(x, y){
    x = Data[x+y*TilesX]%y;
    y = Math.floor(Data[x+y*TilesX]/y);
  }

  Game = (function () {
    function Game() {
    }

    Game.prototype.init = function (resourceLoader) {
      loader = resourceLoader;
      init();

      setTimeout(function () {
        init();
      }, 2000);
    }

    return Game;
  }());

  return Game;
});