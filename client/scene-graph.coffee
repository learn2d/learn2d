define [
  'cs!level'
], ->
  Level = require 'level'

  class SceneGraph
    constructor: () ->
      @level = new Level('test')

    getLevel: () ->
      @level