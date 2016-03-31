###
  带关闭按钮的对话框
###

@Dialog = cc.Layer.extend
  dialogLayer: null
  popDialog : null
  btnClose: null

  closeCallback : null # 关闭按钮回调

  ctor : ->
    @_super(cc.color(0,0,0, 0))
    @initDialog()
    @initCloseBtn()

  initDialog : ->
    # 创建弹窗背景图片
    stDialogBg = new cc.Sprite res.igDialogBg
    # 创建一个layer用于存放弹窗，layer的宽和高等于弹窗图片的大小
    @dialogLayer = new cc.LayerColor cc.color(0,0,0,0), stDialogBg.width, stDialogBg.height
    @dialogLayer.attr
      x : cc.winSize.width / 2 - @dialogLayer.width / 2
      y : cc.winSize.height / 2 - @dialogLayer.height / 2

    stDialogBg.attr
      x : @dialogLayer.width / 2
      y : @dialogLayer.height / 2

    @dialogLayer.addChild stDialogBg, 0
    @popDialog = new PopDialog @dialogLayer, true, THIS.isCloseDialogOutside
    @addChild @popDialog

  initCloseBtn : ->
    @btnClose = new ccui.Button()
    @btnClose.loadTextureNormal res.igBtnClose, ccui.Widget.LOCAL_TEXTURE
    @btnClose.setPressedActionEnabled true
    @btnClose.attr
      x: @dialogLayer.width - 40
      y: @dialogLayer.height - 40
    @btnClose.setTouchEnabled true
    @dialogLayer.addChild @btnClose, 5

    self = @

    @btnClose.addTouchEventListener (touch, event)->
      if event is ccui.Widget.TOUCH_ENDED
        LogTool.c "点击关闭按钮"
        self.popDialog.hidden self.closeCallback
    , @btnClose

  setHiddenCallback : (fun) ->
    @popDialog.hiddenCallback = fun

  setTouchbgFlag : (flag) ->
    @popDialog.touchbg_flag = flag