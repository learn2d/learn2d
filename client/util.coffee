define ->
  DIR_UP: 0
  DIR_LEFT: 1
  DIR_DOWN: 2
  DIR_RIGHT: 3

  KEY_UP: 38
  KEY_LEFT: 37
  KEY_DOWN: 40
  KEY_RIGHT: 39

  vectorX: (direction) ->
    # up
    if direction is 0
      0
    # left
    else if direction is 1
      -1
    # down
    else if direction is 2
      0
    # right
    else if direction is 3
      1

  vectorY: (direction) ->
    # up
    if direction is 0
      -1
    # left
    else if direction is 1
      0
    # down
    else if direction is 2
      1
    # right
    else if direction is 3
      0