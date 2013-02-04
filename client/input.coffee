define [
  'bean'
], ->
  bean = require 'bean'

  class Input
    constructor: (@context, @viewport) ->
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
            if e.which is 220
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
          return unless e.button is 0

          mousePos = @_getPosition(e)
          @mouseX = mousePos.x
          @mouseY = mousePos.y
          @mouseDown = true

        bean.add document, 'touchstart', (e) =>
          mousePos = @_getPosition(e)
          console.log(mousePos)
          @mouseX = mousePos.x
          @mouseY = mousePos.y
          @mouseDown = true

        bean.add document, 'mouseup', (e) =>
          return unless e.button is 0

          @mouseDown = false

        bean.add document, 'touchend', (e) =>
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
    _getPosition: (e) ->
      findPos = (obj) ->
        curleft = 0
        curtop = 0

        if obj.offsetParent
          loop
            curleft += obj.offsetLeft
            curtop += obj.offsetTop

            break unless obj = obj.offsetParent

          return {
            x: curleft
            y: curtop
          }

        undefined

      pageX = e.pageX
      pageY = e.pageY
      if pageX is undefined
        pageX = e.touches[0].pageX
        pageY = e.touches[0].pageY

      pos = findPos(@context.canvas)
      x = pageX - pos.x - @viewport.offsetX()
      y = pageY - pos.y - @viewport.offsetY()

      return {
        x: x
        y: y
      }

    # called for each game loop
    loop: ->
