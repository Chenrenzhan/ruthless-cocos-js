###
  游戏重来
###


@RegameDialog = Dialog.extend
  btnAgain : null  # 重来
  btnBack : null   # 返回
  btnHighAgain : null # 最高分
  funOk : null  # 确认回调函数
  funBack : null # 取消回调函数

  isHigh : null # 是否为最高分

  ctor : (_isHigh)->
    @_super()
    @isHigh = _isHigh
    if @isHigh
      @initBtnHighAgain()
      @initHighTip()
    else
      @initBtnAgain()
    @initBtnBack()

  initBtnAgain : ->
    @btnAgain = new ccui.Button()
    @btnAgain.loadTextureNormal res.igBtnAgain, ccui.Widget.LOCAL_TEXTURE
    @btnAgain.setPressedActionEnabled true
    @btnAgain.setTouchEnabled true
    @btnAgain.attr
      x: @dialogLayer.width / 2
      y: @dialogLayer.height / 2 + @btnAgain.height / 2 + 25

    @dialogLayer.addChild @btnAgain, 5
    self = @
    @btnAgain.addTouchEventListener (touch, event)->
      if event is ccui.Widget.TOUCH_ENDED
        LogTool.c "点击重来按钮"
        self.popDialog.hidden(self.funOk)
    , @btnAgain

  initBtnHighAgain : ->
    @btnAgain = new ccui.Button()
    @btnAgain.loadTextureNormal res.igBtnHighAgain, ccui.Widget.LOCAL_TEXTURE
    @btnAgain.setPressedActionEnabled true
    @btnAgain.setTouchEnabled true
    @btnAgain.attr
      x: @dialogLayer.width / 2
      y: @dialogLayer.height / 2 + @btnAgain.height / 2 + 25

    @dialogLayer.addChild @btnAgain, 5
    self = @
    @btnAgain.addTouchEventListener (touch, event)->
      if event is ccui.Widget.TOUCH_ENDED
        LogTool.c "点击最高分重来按钮"
        self.popDialog.hidden(self.funOk)
    , @btnAgain

  initBtnBack : ->
    @btnBack = new ccui.Button()
    @btnBack.loadTextureNormal res.igBtnBack, ccui.Widget.LOCAL_TEXTURE
    @btnBack.setPressedActionEnabled true
    @btnBack.setTouchEnabled true
    @btnBack.attr
      x: @dialogLayer.width / 2
      y: @dialogLayer.height / 2 - @btnBack.height / 2 - 25

    @dialogLayer.addChild @btnBack, 5
    self = @
    @btnBack.addTouchEventListener (touch, event)->
      if event is ccui.Widget.TOUCH_ENDED
        LogTool.c "点击返回按钮"
        try
          if typeof self.funBack is "function"
            self.funBack()
          else
            LogTool.c "funBack is not a function"
        catch error
          LogTool.c error
        self.popDialog.hidden()
    , @btnBack

  initHighTip : ->
    flower = new cc.Sprite res.igFlower
    flower.attr
      x : @dialogLayer.width - flower.width / 2 - 60
      y : @dialogLayer.height - flower.height / 2 - 20
    @dialogLayer.addChild flower, 0

    best = new cc.LabelTTF "you are the best ... ..."
    best.fontSize = 30
    best.fillStyle = cc.color 0, 0, 0, 255
    best.attr
      x : flower.x - best.width / 2 - flower.width / 2 - 20
      y : @dialogLayer.height - flower.height / 2 - 10
    @dialogLayer.addChild best, 0

    high = new cc.LabelTTF "最高分~~~耶耶~~~"
    high.fontSize = 30
    high.fillStyle = cc.color 0, 0, 0, 255
    high.attr
      x : @dialogLayer.width - high.width / 2 - 80
      y : 50
    @dialogLayer.addChild high, 0
