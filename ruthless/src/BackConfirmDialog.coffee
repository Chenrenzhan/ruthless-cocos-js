###
  返回游戏确认对话框
###

@BackConfirmDialog = Dialog.extend
  btnOk : null
  btnCancel : null

  funOk : null  # 确认回调函数
  funCancel : null # 取消回调函数

  ctor : ->
    @_super()
    @initBtnOk()
    @initBtnCancel()

  initBtnOk : ->
    @btnOk = new ccui.Button()
    @btnOk.loadTextureNormal res.igBtnOk, ccui.Widget.LOCAL_TEXTURE
    @btnOk.setPressedActionEnabled true
    @btnOk.setTouchEnabled true
    @btnOk.attr
      x: @dialogLayer.width / 2
      y: @dialogLayer.height / 2 + @btnOk.height / 2 + 25

    @dialogLayer.addChild @btnOk, 5
    self = @
    @btnOk.addTouchEventListener (touch, event)->
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
    , @btnOk

  initBtnCancel : ->
    @btnCancel = new ccui.Button()
    @btnCancel.loadTextureNormal res.igBtnCancel, ccui.Widget.LOCAL_TEXTURE
    @btnCancel.setPressedActionEnabled true
    @btnCancel.setTouchEnabled true
    @btnCancel.attr
      x: @dialogLayer.width / 2
      y: @dialogLayer.height / 2 - @btnCancel.height / 2 - 25

    @dialogLayer.addChild @btnCancel, 5
    self = @
    @btnCancel.addTouchEventListener (touch, event)->
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
    , @btnCancel