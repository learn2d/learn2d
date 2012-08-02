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
          @timer.delay = 1000
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
          blocked = @_checkWall(playerSpeed, k, playerX, playerY)

          if not blocked[0]
            playerX += @util.vectorX(k) * playerSpeed
            playerY += @util.vectorY(k) * playerSpeed

          else if blocked[1] and not blocked[2]
            playerX -= @util.vectorX((k+1)%2)*slideDistance
            playerY -= @util.vectorY((k+1)%2)*slideDistance

          else if not blocked[1] and blocked[2]
            playerX += @util.vectorX((k+1)%2)*slideDistance
            playerY += @util.vectorY((k+1)%2)*slideDistance

      if aniName isnt @player.getAni()
        @player.setAni aniName

      @player.x = playerX
      @player.y = playerY

      @timer.delay = 50

    _checkWall: (playerSpeed, k, playerX, playerY) ->
      check_blocked = [false, false]

      for w in [0..1]
        for i in [0...playerSpeed]
          checkx = ((playerX+5+Math.abs(@util.vectorX(k)*16)-@util.vectorX((k+1)%2)*w*16)+@util.vectorX(k)*(16+i))+(if [0,2].indexOf(k) isnt -1 then 1 else 0)
          checky = ((playerY+18-Math.abs(@util.vectorX(k)*16)-@util.vectorY((k+1)%2)*w*16)+@util.vectorY(k)*(16+i))+(if [1,3].indexOf(k) isnt -1 then 1 else 0)

          check_blocked[w] = @level.onWall(checkx,checky,(if [0,2].indexOf(k) isnt -1 then 15 else 1),(if [1,3].indexOf(k) isnt -1 then 15 else 1))

          if check_blocked[0] + check_blocked[1] > 0
            playerX += (@util.vectorX(k)*i)
            playerY += (@util.vectorY(k)*i)
            break

      return [check_blocked[0] + check_blocked[1], check_blocked[0], check_blocked[1]]
