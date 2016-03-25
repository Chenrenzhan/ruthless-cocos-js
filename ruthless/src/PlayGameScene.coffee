###
  游戏页面
###

@PlayGameScene = BaseLayer.extend
  stMainBg : null
  btnBack : null
  stStar : null
  lbResultNumber : null

  lbHighestRecord : null

  score : null # 成绩
  punish : null # 经典模式下的惩罚
  time : null # 倒计时

  lbFirst : null # 显示成绩label
  lbSecond : null # 显示惩罚或者倒计时

  mode: null # 游戏模式 0--经典模式， 1--挑战模式， 2--街机模式

  numberSprites : null  # 六个移动数字sprite的数字
  resultNumber : null # 结果
  firstSelectedNumber : null # 选择的第一个数

  countNumber : 0 # 单局已经下落的数字数目，


  ctor: (_type)->
    @_super()
    @mode = _type
    @initMainBg()
    @initBackArrows()
    @initStar()
    @initScore()
#    @initHighestRecord()
    @initMovingNumber()

#    @nextGame(@)

  initMainBg : ->
    @stMainBg = new cc.Sprite res.igGameBg
    @stMainBg.attr
      x: THIS.winSize.width / 2,
      y: THIS.winSize.height / 2

    @addChild @stMainBg, 0

  initBackArrows : ->
    @btnBack = new ccui.Button()
    @btnBack.loadTextureNormal res.igBtnBackArrows, ccui.Widget.LOCAL_TEXTURE
    @btnBack.setPressedActionEnabled true
    @btnBack.setTouchEnabled true
    @btnBack.attr
      x: @btnBack.width / 2 + 20
      y: THIS.winSize.height - @btnBack.height / 2 - 20

    @addChild @btnBack, 15
    self = @
    @btnBack.addTouchEventListener (touch, event)->
      if event is ccui.Widget.TOUCH_ENDED
        LogTool.c "返回"
        self.pauseNumbers self # 暂停数字下落动画
        backDialog = new BackConfirmDialog()
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
      x : THIS.winSize.width / 2
      y : THIS.winSize.height - @stStar.height / 2 - 30

    @lbResultNumber = cc.LabelTTF.createWithFontDefinition()
    @lbResultNumber.fontSize = 60
    @lbResultNumber.fillStyle = cc.color 255, 0, 0, 255
    @lbResultNumber.string = "25"
    @lbResultNumber.attr
      x : @stStar.width / 2
      y : @stStar.height / 2
    @stStar.addChild @lbResultNumber, 0

    @addChild @stStar, 20

  initHighestRecord : ->
    label = new cc.LabelTTF "最高纪录："
    label.fillStyle = cc.color 79,79,79,255
    label.fontSize = 35
    label.attr
      x : THIS.winSize.width - 300
      y : THIS.winSize.height - label.height / 2 - 30
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
     x : THIS.winSize.width - stFirst.width / 2 - 50
     y : THIS.winSize.height - stFirst.height / 2 - 10
    @addChild stFirst, 20

    @lbFirst = new cc.LabelTTF()
    @lbFirst.fontSize = 40
    @lbFirst.fillStyle = cc.color 20, 20, 20, 255
    @lbFirst.setDimensions(0, 0)
    @lbFirst.string = 144
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
    @lbSecond.string = "03:00"
    @lbSecond.attr
      x : stSecond.width / 2
      y : stSecond.height / 2
    stSecond.addChild @lbSecond, 0

  initMovingNumber : ->
    @numberSprites = new Array()
    for i in [0..5]
      @scheduleOnce ->
        @numberSprites.push @generateNumber()
      , Math.random() * 5


  generateNumber : ->
    self = @
    number = Math.round(Math.random() * 100)
    numberSprite = new MovingNumber 0.1, number
    self.countNumber++
    if self.countNumber is THIS.numberCount
      self.countNumber = 0
      numberSprite.finishCallback = ->
        self.numberFallFinish(self)

    @addChild numberSprite, 5
    cc.eventManager.addListener numberSprite.listener( ->
        return (nu) ->
          LogTool.c "click number = #{nu}")
    , numberSprite
    numberSprite.startAction ->
      LogTool.c "start action"
    return numberSprite

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

  nextGame : (self) ->
    if self.numberSprites isnt null
      for number in self.numberSprites
        number.removeFromParent(true)
    self.initMovingNumber()

  numberFallFinish : (self) ->
    self.nextGame(self)
    self.countNumber = 0




