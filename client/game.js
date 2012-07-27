define(['flywheel', 'cs!level-renderer'], function () {
  var flywheel = require('flywheel');
  var LevelRenderer = require('level-renderer');

  var Game = (function () {
    function Game(resourceLoader, context) {
      this.loop = this.loop.bind(this);

      this.loader = resourceLoader;
      this.context = context;
      this.fw = flywheel(this.loop, this.context.canvas);
      this.levelRenderer = new LevelRenderer(this.loader, this.context);
    }

    Game.prototype.init = function () {
      this.fw.start();
    };

    Game.prototype.draw = function () {
      this.levelRenderer.draw();
    };

    Game.prototype.loop = function (timeDelta) {
      // TODO: handle input here

      // TODO: run scripts here

      // TODO: handle network updates here

      // Render all cameras
      this.draw();
    };

    return Game;
  }());

  return Game;
});
