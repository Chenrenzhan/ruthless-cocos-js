###
  菜单弹出对话框
###

@MenuDialog = cc.LayerColor.extend
  dialog : null
  dialogLayer: null

  btnClose: null
  btnExit: null
  btnSetting: null
  btnAbout: null

  ctor : ->
    @_super(cc.color(0,0,0, 0))

    @dialog = new Dialog()
    @dialogLayer = @dialog.dialogLayer

    @addChild @dialog
    @initExitBtn()
    @initSettingBtn()
    @initAboutBtn()

  initExitBtn : ->
    @btnExit = new ccui.Button()
    @btnExit.loadTextureNormal res.igBtnExitGame, ccui.Widget.LOCAL_TEXTURE
    @btnExit.setPressedActionEnabled true
    @btnExit.setTouchEnabled true
    @btnExit.attr
      x: @dialogLayer.width / 2
      y: @dialogLayer.height - 150

    @dialogLayer.addChild @btnExit, 5
    self = @
    @btnExit.addTouchEventListener (touch, event)->
      if event is ccui.Widget.TOUCH_ENDED
        LogTool.c "点击退出游戏按钮按钮"
        #退出游戏
        self.dialog.popDialog.hidden()
        cc.director.end()
    , @btnExit

  initSettingBtn : ->
    @btnSetting = new ccui.Button()
    @btnSetting.loadTextureNormal res.igBtnSettingGame, ccui.Widget.LOCAL_TEXTURE
    @btnSetting.setPressedActionEnabled true
    @btnSetting.setTouchEnabled true
    @btnSetting.attr
      x: @dialogLayer.width / 2
      y: @dialogLayer.height / 2 - 25

    @dialogLayer.addChild @btnSetting, 5
    self = @
    @btnSetting.addTouchEventListener (touch, event)->
      if event is ccui.Widget.TOUCH_ENDED
        LogTool.c "点击游戏设置按钮"
        self.dialog.popDialog.hidden()
        self.scheduleOnce ->
          self.addChild new GameSettingDialog(), 5
        , THIS.nextDialogDelay
    , @btnSetting

  initAboutBtn : ->
    @btnAbout = new ccui.Button()
    @btnAbout.loadTextureNormal res.igBtnAboutGame, ccui.Widget.LOCAL_TEXTURE
    @btnAbout.setPressedActionEnabled true
    @btnAbout.setTouchEnabled true
    @btnAbout.attr
      x: @dialogLayer.width / 2
      y: 100

    @dialogLayer.addChild @btnAbout, 5
    self = @
    @btnAbout.addTouchEventListener (touch, event)->
      if event is ccui.Widget.TOUCH_ENDED
        LogTool.c "点击关于游戏按钮"
        self.dialog.popDialog.hidden()
        self.scheduleOnce ->
          self.addChild new AboutGameDialog(), 5
        , THIS.nextDialogDelay
    , @btnAbout

