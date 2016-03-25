###
  游戏设置对话框
###

@GameSettingDialog = Dialog.extend
  btnMusic : null
  btnDifficult : null

  ctor : ->
    @_super()
    @initBtnMusic()
    @initBtnDifficult()

  initBtnMusic : ->
    @btnMusic = new ccui.Button()
    @btnMusic.loadTextureNormal res.igBtnMusic, ccui.Widget.LOCAL_TEXTURE
    @btnMusic.setPressedActionEnabled true
    @btnMusic.setTouchEnabled true
    @btnMusic.attr
      x: @dialogLayer.width / 2
      y: @dialogLayer.height / 2 + @btnMusic.height / 2 + 25

    @dialogLayer.addChild @btnMusic, 5
    self = @
    @btnMusic.addTouchEventListener (touch, event)->
      if event is ccui.Widget.TOUCH_ENDED
        LogTool.c "点击音乐按钮"
        self.popDialog.hidden()
        self.scheduleOnce ->
          self.addChild new MusicSettingDialog(), 5
        , THIS.nextDialogDelay
    , @btnMusic

  initBtnDifficult : ->
    @btnDifficult = new ccui.Button()
    @btnDifficult.loadTextureNormal res.igBtnDifficult, ccui.Widget.LOCAL_TEXTURE
    @btnDifficult.setPressedActionEnabled true
    @btnDifficult.setTouchEnabled true
    @btnDifficult.attr
      x: @dialogLayer.width / 2
      y: @dialogLayer.height / 2 - @btnDifficult.height / 2 - 25

    @dialogLayer.addChild @btnDifficult, 5
    self = @
    @btnDifficult.addTouchEventListener (touch, event)->
      if event is ccui.Widget.TOUCH_ENDED
        LogTool.c "点击游戏设置按钮"
        #退出游戏
        self.popDialog.hidden()
        self.scheduleOnce ->
          self.addChild new DifficultSettingDialog(), 5
        , THIS.nextDialogDelay
    , @btnDifficult