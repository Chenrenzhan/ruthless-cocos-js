###
  移动飘落的数字
###

@MovingNumber = cc.Sprite.extend
  parent : null # 上层节点
  speed : null # 飘落速度
  number : null # 数字
  lbNumber : null
  rotationAngle : null # 旋转角度
  moveAction : null # 移动动画
  rotateAction : null # 旋转动画动画

  finishCallback : null # 下落到底部回调

  ctor : (_speed, _number) ->
    @_super()
    @speed = _speed
    @number = _number
    @rotationAngle = @getRotateAngle()
    @scheduleUpdate()

    @initSprite()

  initSprite : ->
    @initWithFile res.igNumberBg
    offsetSide = if @width > @height then @width else @height
    px = @getRandomX()
    if px < offsetSide
      px = offsetSide
    else if px > THIS.winSize.width - offsetSide
      px = THIS.winSize.width - offsetSide
    @attr
      x : px
      y : THIS.winSize.height + offsetSide / 2
    @setRotation @rotationAngle

    @lbNumber = new cc.LabelTTF "#{@number}"
    @lbNumber.fontSize = 50
    @lbNumber.fillStyle = cc.color 34,34,34,255
    @lbNumber.setRotation -@rotationAngle
    @lbNumber.attr
      x : @width / 2 - 20
      y : @height / 2 - 10
    @addChild @lbNumber, 0
    offsetX = 0
    randomX = @getRandomX()
    if randomX < offsetSide
      offsetX = offsetSide - @x
    else if randomX > THIS.winSize.width - offsetSide
      offsetX = THIS.winSize.width - offsetSide - @x
    @moveAction = cc.moveBy(1, cc.p(offsetX, -(THIS.winSize.height + offsetSide * 2))).speed(@speed).easing(cc.easeIn(1.0));
    @rotateAction = cc.rotateBy(THIS.rotationTime, 360, 360).repeatForever()

  # 生成横轴随机位置，左右边距为20
  getRandomX : ->
    Math.random() * (THIS.winSize.width - 40) + 20

  # 生成随机的旋转角度
  getRotateAngle : ->
    Math.random() * 360

  # 开始动画 fun--回调
  startAction : (fun) ->
    try
      fun() if typeof fun is "function"
    catch error
      LogTool.c "fun is not a function"
    @runAction @moveAction
    @runAction @rotateAction if THIS.isRotation

  pauseAction : (fun) ->
  #    @stopAction @action
    @pause()
    try
      fun() if typeof fun is "function"
    catch error
      LogTool.c "fun is not a function"
  resumeAction : (fun) ->
  #    @stopAction @action
    @resume()
    try
      fun() if typeof fun is "function"
    catch error
      LogTool.c "fun is not a function"

  stopAction : (fun) ->
  #    @stopAction @action
    @stopAllActons()
    try
      fun() if typeof fun is "function"
    catch error
      LogTool.c "fun is not a function"

  listener : (fun) ->
    self = @
    return cc.EventListener.create
      event: cc.EventListener.TOUCH_ONE_BY_ONE,
      swallowTouches: true                   # 设置是否吞没事件，在 onTouchBegan 方法返回 true 时吞没
      onTouchBegan: (touch, event) ->
        # 实现 onTouchBegan 事件回调函数
        target = event.getCurrentTarget()  #获取事件所绑定的 target
        # 获取当前点击点所在相对按钮的位置坐标
        locationInNode = target.convertToNodeSpace touch.getLocation()
        s = target.getContentSize()
        rect = cc.rect 0, 0, s.width, s.height
        if  cc.rectContainsPoint rect, locationInNode        #点击范围判断检测
          return true
        # 返回false，事件不继续传递到onTouchMived和onTouchEnd事件
        return false;

      onTouchEnded: (touch, event) ->
        # 点击事件结束处理
        self.lbNumber.fillStyle = THIS.selectedNumberColor # 直接设置颜色没效果，需要改变字符串才会重新渲染
        self.lbNumber.setString " "
        self.lbNumber.setString "#{self.number}"
        try
          if typeof fun is "function" and typeof fun() is "function"
            fun() (self.number)
          else
            LogTool.c "fun is not a function"
        catch error
          LogTool.e error

  update : (dt) ->
    if @.y < -(@height / 2 * 3)
      @cleanup()
      LogTool.c @lbNumber.string
      try
        @finishCallback() if typeof @finishCallback is "function"
      catch error
        LogTool.e error