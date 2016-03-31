###
  游戏页面
###

@PlayGameLayer= BaseLayer.extend
  stMainBg : null
  btnBack : null
  stStar : null
  lbResultNumber : null
  resultNumber : null
  numbersValues : null #六个数字的数组

  lbHighestRecord : null

  score : null # 成绩
  punish : null # 经典模式下的惩罚
  timeSeconds : null # 倒计时
  sec : 0

  lbFirst : null # 显示成绩label
  lbSecond : null # 显示惩罚或者倒计时

  mode: null # 游戏模式 0--经典模式， 1--挑战模式， 2--街机模式
  difficult : null # 难度

  numberSprites : null  # 六个移动数字sprite的数字
  resultNumber : null # 结果
  firstSelectedNumber : null # 选择的第一个数

  createNumber : 0 # 单局已经创建的数字

  speed : 0.1 # 每一关数字下落加速度


  ctor: (_type)->
    @_super()
    @mode = _type
    LogTool.c "_type  " + _type
    @initMainBg()
    @initBackArrows()
    @initStar()
    @initScore()
#    @initHighestRecord()
    @initMovingNumber()

#    @scheduleUpdate() # 开启update函数每帧更新
#    @nextGame(@)

  initMainBg : ->
    @stMainBg = new cc.Sprite res.igGameBg
    @stMainBg.attr
      x: cc.winSize.width / 2,
      y: cc.winSize.height / 2

    @addChild @stMainBg, 0

  initBackArrows : ->
    @btnBack = new ccui.Button()
    @btnBack.loadTextureNormal res.igBtnBackArrows, ccui.Widget.LOCAL_TEXTURE
    @btnBack.setPressedActionEnabled true
    @btnBack.setTouchEnabled true
    @btnBack.attr
      x: @btnBack.width / 2 + 20
      y: cc.winSize.height - @btnBack.height / 2 - 20

    @addChild @btnBack, 50
    self = @
    @btnBack.addTouchEventListener (touch, event)->
      if event is ccui.Widget.TOUCH_ENDED
        LogTool.c "返回"
        self.pauseNumbers self # 暂停数字下落动画
        backDialog = new BackConfirmDialog()
        backDialog.setHiddenCallback ->
          LogTool.c "hiddenCallback"
          self.resumeNumbers self # 恢复数字下落动画
        backDialog.closeCallback = ->
          LogTool.c "closeCallback"
          self.resumeNumbers self # 恢复数字下落动画
        backDialog.funOk = ->
          LogTool.c "click dialog ok button"
          self.stopNumbers self # 停止数字下落
        backDialog.funCancel = ->
          LogTool.c "click dialog cancel button"
          self.resumeNumbers self # 恢复数字下落动画
        self.addChild backDialog, 20
    , @btnBack

  initStar : ->
    @stStar = new cc.Sprite res.igStar
    @stStar.attr
      x : cc.winSize.width / 2
      y : cc.winSize.height - @stStar.height / 2 - 30

    @lbResultNumber = new cc.LabelTTF "0"
    @lbResultNumber.fontSize = 60
    @lbResultNumber.fillStyle = cc.color 255, 0, 0, 255
    @lbResultNumber.string = "25"
    @lbResultNumber.attr
      x : @stStar.width / 2
      y : @stStar.height / 2
    @stStar.addChild @lbResultNumber, 0

    @addChild @stStar, 20

# 显示最高纪录已经去掉
  initHighestRecord : ->
    label = new cc.LabelTTF "最高纪录："
    label.fillStyle = cc.color 79,79,79,255
    label.fontSize = 35
    label.attr
      x : cc.winSize.width - 300
      y : cc.winSize.height - label.height / 2 - 30
    @addChild label, 0

    @lbHighestRecord = new cc.LabelTTF()
    @lbHighestRecord.fillStyle = cc.color 20,20,20,255
    @lbHighestRecord.fontSize = 35
    @lbHighestRecord.string = "#{THIS.highestRecord}"
    @lbHighestRecord.attr
      x : label.x + label.width / 2 +  10
      y : label.y
    @addChild @lbHighestRecord, 0

  initScore : ->
    stFirst = new cc.Sprite res.igScoreFrame
    stFirst.attr
      x : cc.winSize.width - stFirst.width / 2 - 50
      y : cc.winSize.height - stFirst.height / 2 - 10
    @addChild stFirst, 20

    @lbFirst = new cc.LabelTTF()
    @lbFirst.fontSize = 40
    @lbFirst.fillStyle = cc.color 20, 20, 20, 255
    @lbFirst.setDimensions(0, 0)
    @lbFirst.attr
      x : stFirst.width / 2
      y : stFirst.height / 2
    stFirst.addChild @lbFirst, 0

    stSecond =new cc.Sprite res.igScoreFrame
    stSecond.attr
      x : stFirst.x
      y : stFirst.y - stFirst.height / 2 - 5
    @addChild stSecond, 20

    @lbSecond = new cc.LabelTTF()
    @lbSecond.fontSize = 40
    @lbSecond.fillStyle = cc.color 79, 79, 79, 255
    @lbSecond.setDimensions(0, 0)

    @lbSecond.attr
      x : stSecond.width / 2
      y : stSecond.height / 2
    stSecond.addChild @lbSecond, 0
    @resetScore(@)

  resetScore : (self) ->
    self.lbFirst.string = 0
    switch self.mode
      when THIS.gameMode.classics then  self.lbSecond.string = THIS.maxError + ""
      when THIS.gameMode.challenge
        self.lbSecond.string = THIS.countDown.challenge
        times = THIS.countDown.challenge.split ":"
        self.timeSeconds = parseInt(times[0]) * 60 + parseInt(times[1])
        @scheduleUpdate() # 开启update函数每帧更新
      when THIS.gameMode.arcade
        self.lbSecond.string = THIS.countDown.arcade
        times = THIS.countDown.arcade.split ":"
        self.timeSeconds = parseInt(times[0]) * 60 + parseInt(times[1])
        @scheduleUpdate() # 开启update函数每帧更新

  initMovingNumber : ->
    @generateNumber()
    @lbResultNumber.string = @resultNumber + ""
    @numberSprites = new Array()
    for i in [0..5]
      @scheduleOnce ->
        @numberSprites.push @generateNumberSprite()
      , Math.random() * THIS.randomFall


  generateNumberSprite : ->
    self = @
    numberSprite = new MovingNumber @speed, @numbersValues[@createNumber]
    self.createNumber++
    if self.createNumber is THIS.numberCount # 创建最后一个时，监听下落到底事件
      self.createNumber = 0
      numberSprite.finishCallback = ->
        self.numberFallFinish(self)

    @addChild numberSprite, 5
    cc.eventManager.addListener numberSprite.listener( ->
        return (nu) ->
          if self.firstSelectedNumber is null
            self.firstSelectedNumber  = nu
          else
            result = nu + self.firstSelectedNumber
            self.firstSelectedNumber = null

            if result is self.resultNumber
              score = self.lbFirst.string
              score++
              self.lbFirst.string = score
              self.nextGame self, true
            else
              self.errorNumber self
      )
    , numberSprite
    numberSprite.startAction ->
      LogTool.c "start action"
    return numberSprite

  generateNumber : ->
    @numbersValues = new Array()
    switch THIS.gameDifficult
      when THIS.difficult.low
        @generateAddNumber THIS.difficultScope.low.max, THIS.difficultScope.low.min
      when THIS.difficult.middle
        @generateAddNumber THIS.difficultScope.middle.max, THIS.difficultScope.middle.min
      when THIS.difficult.high
        # todo 数字产生规则不同
        @generateAddNumber THIS.difficultScope.high.max, THIS.difficultScope.high.min

# 产生相加的两个数字
  generateAddNumber : (max, min)->
    @resultNumber = Math.random() * (max - min) + min
    @resultNumber = Math.round(@resultNumber)
    for i in [0...THIS.numberCount/2]
      value = Math.random() * (@resultNumber - min) + min
      value = Math.round(value)
      @numbersValues[i] = value
      @numbersValues[i + THIS.numberCount/2] = @resultNumber - value

  pauseNumbers : (self) ->
    @pause()
    if self.numberSprites isnt null
      for number in self.numberSprites
        number.pauseAction()
  resumeNumbers : (self) ->
    @resume()
    if self.numberSprites isnt null
      for number in self.numberSprites
        number.resumeAction()
  stopNumbers : (self) ->
    @cleanup()
    if self.numberSprites isnt null
      for number in self.numberSprites
        number.cleanup()

# 第二个参数，是否加速
  nextGame : (self, isAcceler = true) ->
    if isAcceler
      accelerometer = 0.01
      if THIS.gameDifficult is THIS.difficult.low then accelerometer = THIS.accelerometer.low
      if THIS.gameDifficult is THIS.difficult.middle then accelerometer = THIS.accelerometer.middle
      if THIS.gameDifficult is THIS.difficult.high then accelerometer = THIS.accelerometer.high
      self.speed += accelerometer
    self.firstSelectedNumber = null
    if self.numberSprites isnt null
      for number in self.numberSprites
        number.removeFromParent true
    self.initMovingNumber()

  newGame : (self) ->
    self.speed = 0.1
    self.resetScore self
    self.nextGame self, false

  numberFallFinish : (self) ->
    self.errorNumber self
    #    self.nextGame(self)
    self.createNumber = 0

# 选择错误的数字或者错过数字
  errorNumber : (self)->
    switch self.mode
      when THIS.gameMode.classics
        error = self.lbSecond.string
        error--
        self.lbSecond.string = error
        if error > 0
          self.nextGame self, false
        else
          self.gameOver self

      when THIS.gameMode.challenge, THIS.gameMode.arcade
        score = self.lbFirst.string
        score--
        self.lbFirst.string = score
        if score <= 0
          self.gameOver self
        else
          self.nextGame self, false

  gameOver : (self)->
    self.stopNumbers self
    score = self.lbFirst.string
    if self.mode is THIS.gameMode.classics then  highScore = THIS.highestRecord.classics
    if self.mode is THIS.gameMode.challenge then highScore = THIS.highestRecord.challenge
    if self.mode is THIS.gameMode.arcade then highScore = THIS.highestRecord.arcade
    isHigh = false
    if score > highScore
      isHigh = true
      switch self.mode
        when THIS.gameMode.classics
          THIS.highestRecord.classics = score
          THIS.LS.setItem THIS.HIGH_CLASSIC, score
        when THIS.gameMode.challenge
          THIS.highestRecord.challenge = score
          THIS.LS.setItem THIS.HIGH_CHALLENGE, score
        when THIS.gameMode.arcade
          THIS.highestRecord.arcade = score
          THIS.LS.setItem THIS.HIGH_ARCADE, score
    regameDialog = new RegameDialog(isHigh)
    regameDialog.setTouchbgFlag false # 设置点击背景不关闭对话框
    regameDialog.funOk = ->
      self.newGame self
      #      regameDialog.removeFromParent true
      self.btnBack.removeFromParent true
      self.initBackArrows()
    regameDialog.funBack = ->
      cc.director.popScene()
    regameDialog.closeCallback = ->
      cc.director.popScene()
    regameDialog.setHiddenCallback ->
      cc.director.popScene()
    self.addChild regameDialog, 25

  countDown : (dt) ->
    @sec += dt
    if @sec >= 1
      if @timeSeconds <= 0
        LogTool.c " 倒计时结束，游戏结束"
        @unscheduleUpdate()
        @gameOver @
      else
        @timeSeconds--
        timeStr = moment(@timeSeconds * 1000 ).format("mm:ss")
        @lbSecond.string = timeStr
      #    else
      @sec = 0

  update : (dt) ->
    @countDown dt




@PlayGameScene = cc.Scene.extend
  mode : 0
  ctor : (_type) ->
    this._super()
    @mode = _type
  onEnter: ->
    this._super()
    layer = new PlayGameLayer(@mode)
#    layer.attr
#      x : -cc.winSize.width / 2
#      y : -cc.winSize.height / 2
    @addChild layer