define ->
  class Movement
    constructor: ({@player, @timer, @util, @input, @level}) ->

    onCreated: ->
      @timer.delay = 50
      @swordDelayed = false

    onTimer: ->
      aniName = @player.getAni()

      if aniName is 'female-slash'
        if not @swordDelayed
          @timer.delay = 200
          @swordDelayed = true
          return
        else
          @swordDelayed = false

      aniName = 'female-idle'

      playerSpeed = 8
      slideDistance = 2
      playerX = @player.x
      playerY = @player.y

      for k in [0..3]
        if @input.isDirectionKeyDown(k)
          @player.direction = k
          aniName = 'female-walk'

          xcheck = playerX + @util.vectorX(k) * playerSpeed
          ycheck = playerY + @util.vectorY(k) * playerSpeed

          collision = @level.collisionCheck(xcheck, ycheck)

          if collision? and not collision
            playerX += @util.vectorX(k) * playerSpeed
            playerY += @util.vectorY(k) * playerSpeed

      if aniName isnt @player.getAni()
        @player.setAni aniName

      @player.x = playerX
      @player.y = playerY

      @timer.delay = 50
