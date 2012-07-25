define(['flywheel'], function () {
  var flywheel = require('flywheel');

  var Game = (function () {
    function Game(resourceLoader, canvas, context) {
      this.loop = this.loop.bind(this);

      this.loader = resourceLoader;
      this.canvas = canvas;
      this.context = context;
      this.fw = flywheel(this.loop, this.canvas);
    }

    Game.prototype.init = function (resourceLoader) {
      this.fw.start();
    };

    Game.prototype.loop = function (timeDelta) {
      this.draw();
    };

    Game.prototype.draw = function () {
      this.drawLayers();
    };

    Game.prototype.drawLayers = function () {
      for (var i = 0; i < Level.layers.length; i++) {
        this.drawLayer(i);
      }
    };

    Game.prototype.drawLayer = function (a) {
      var size = Level.tilesets[0].tileheight;
      var border = 0;
      var imageObj = this.loader.loadImage(Level.tilesets[0].image);

      if (imageObj !== null) {
        var TilesX = imageObj.width/size;

        for (var y = 0; y < 32; y++) {
            for (var x = 0; x < 32; x++) {
                var index = Level.layers[a].data[x+y*size];

                if ( index > 0 ){//if null, don't draw a tile
                  var srcx = ((index-1)%TilesX)*size;
                  var srcy = Math.floor((index-1)/TilesX)*size;

                  this.context.drawImage(imageObj, srcx, srcy, size, size, x * size, y * size, size, size);
                } //end if
            }
        }
      }
    };

    return Game;
  }());

  return Game;
});
