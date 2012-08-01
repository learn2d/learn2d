define [
  'bean'
], ->
  bean = require 'bean'

  class Input
    constructor: (@context) ->
        @input = {}
        @chatHasFocus = false
        @playerChat = undefined

        @mouseDown = false

        @mouseX = 200
        @mouseY = 200

        @initialize()

    initialize: ->
        chatbox = document.getElementById 'chatbox'
        chatForm = document.getElementById 'chat-form'

        bean.add chatbox, 'focus', =>
            @chatHasFocus = true

        bean.add chatbox, 'blur', =>
            @chatHasFocus = false

        bean.add chatForm, 'submit', (e) =>
            e.preventDefault()
            @playerChat = chatbox.value
            chatbox.value = ''

        @bindControls()

    bindControls: ->
        chatbox = document.getElementById 'chatbox'

        bean.add document, 'keydown', (e) =>
            if e.which is 189
              debugger
            if e.which is 9
                e.preventDefault()

                unless @chatHasFocus
                    # remove all inputs
                    for own key, value of @input
                        delete @input[key]

                    chatbox.focus()
                else
                    chatbox.blur()
            else if not @chatHasFocus
                e.preventDefault()

                keyCode = e.which
                @input[keyCode] = true

        bean.add document, 'keyup', (e) =>
            unless @chatHasFocus
                keyCode = e.which
                delete @input[keyCode]

        bean.add document, 'mousedown', (e) =>
          mousePos = @_getPosition(e)
          @mouseX = mousePos.x
          @mouseY = mousePos.y
          @mouseDown = true
        bean.add document, 'mouseup', (e) =>
          @mouseDown = false

    isKeyDown: (keyCode) ->
      @input[keyCode]

    isMouseDown: () ->
      @mouseDown

    getPlayerChat: ->
        @playerChat

    getMouseX: ->
      @mouseX

    getMouseY: ->
      @mouseY

    # get mouse position
    _getPosition: (event) ->
      x = event.clientX + document.body.scrollLeft +
           document.documentElement.scrollLeft
      y = event.pageY

      x -= @context.canvas.offsetLeft

      x: x
      y: y

    # called for each game loop
    loop: ->
