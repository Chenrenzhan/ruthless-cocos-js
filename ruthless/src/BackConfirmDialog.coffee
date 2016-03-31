###
  返回游戏确认对话框
###

@BackConfirmDialog = Dialog.extend
  btnAgain : null
  btnBack : null

  funOk : null  # 确认回调函数
  funCancel : null # 取消回调函数

  ctor : ->
    @_super()
    @initBtnAgain()
    @initBtnBack()

  initBtnAgain : ->
    @btnAgain = new ccui.Button()
    @btnAgain.loadTextureNormal res.igBtnOk, ccui.Widget.LOCAL_TEXTURE
    @btnAgain.setPressedActionEnabled true
    @btnAgain.setTouchEnabled true
    @btnAgain.attr
      x: @dialogLayer.width / 2
      y: @dialogLayer.height / 2 + @btnAgain.height / 2 + 25

    @dialogLayer.addChild @btnAgain, 5
    self = @
    @btnAgain.addTouchEventListener (touch, event)->
      if event is ccui.Widget.TOUCH_ENDED
        LogTool.c "点击确认关闭按钮"
        try
          if typeof self.funOk is "function"
            self.funOk()
          else
            LogTool.c "funOk is not a function"
        catch error
          LogTool.c error

        self.popDialog.hidden()
        cc.director.popScene()
    , @btnAgain

  initBtnBack : ->
    @btnBack = new ccui.Button()
    @btnBack.loadTextureNormal res.igBtnCancel, ccui.Widget.LOCAL_TEXTURE
    @btnBack.setPressedActionEnabled true
    @btnBack.setTouchEnabled true
    @btnBack.attr
      x: @dialogLayer.width / 2
      y: @dialogLayer.height / 2 - @btnBack.height / 2 - 25

    @dialogLayer.addChild @btnBack, 5
    self = @
    @btnBack.addTouchEventListener (touch, event)->
      if event is ccui.Widget.TOUCH_ENDED
        LogTool.c "点击取消按钮"
        try
          if typeof self.funCancel is "function"
            self.funCancel()
          else
            LogTool.c "funCancel is not a function"
        catch error
          LogTool.c error
        self.popDialog.hidden()
    , @btnBack

