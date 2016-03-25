#最外层使用@LoadingLayer目的是暴露出变量到window,即全局变量
#参考http://www.lxway.com/289925114.htm

@LoadingLayer = BaseLayer.extend
#main bg sprite
  stMainBg: null
#title sprite
  stTitle : null
#garlic sprite
  stGarlic: null
#tip frame sprite
  stTipFrame: null
#tip label
  lbTip: null
#progress bar
  pbLoading:null
#progress bar slider sprite
  stSlider: null
#progress bar background
  stBarBg: null
#progress bar render
  stBarFront: null

  ctor: ->
    @_super()

    @initMainBg()

    @initTitle()

    @initProgress()

    @initGarlic()

    @initTip()

    return true;

#初始化背景
  initMainBg : ->
    @stMainBg = new cc.Sprite res.igMainBg
    @stMainBg.attr
      x: THIS.winSize.width / 2,
      y: THIS.winSize.height / 2

    @addChild @stMainBg, 0

  initTitle : ->
    @stTitle = new cc.Sprite res.igTitle
    @stTitle.attr
      x: THIS.winSize.width / 2
      y: THIS.winSize.height - 130
    @addChild @stTitle, 0

  initProgress : ->
    @pbLoading = ccui.Slider.create()
    @pbLoading.loadBarTexture res.igBarBg, ccui.Widget.LOCAL_TEXTURE
    @pbLoading.loadProgressBarTexture res.igBarFront, ccui.Widget.LOCAL_TEXTURE
    @pbLoading.loadSlidBallTextureNormal res.igBarSlider, ccui.Widget.LOCAL_TEXTURE

    rect = @pbLoading.getCapInsetsBarRenderer()
    LogTool.c rect

    @pbLoading.setPercent 2 #97
    @pbLoading.setScale9Enabled false
    @pbLoading.enabled = false

    @pbLoading.attr
      x: THIS.winSize.width / 2 - 50
      y: 180

    @stMainBg.addChild @pbLoading, 0

  initGarlic : ->
    @stGarlic = new cc.Sprite res.igGarlic
    @stGarlic.attr
      x: THIS.winSize.width  - @stGarlic.width / 2 - 170
      y: @stGarlic.height / 2 + 150
    @addChild @stGarlic, 0

  initTip : ->
    @stTip = new cc.Sprite res.igTipFrame
    @stTip.attr
      x: THIS.winSize.width - @stTip.width / 2 - 280
      y: @stTip.height / 2 + 280


    @lbTip = new cc.LabelTTF "算个毛" , "Arial", 50
#    @lbTip.fontSize = 50
    @lbTip.fillStyle = new cc.Color 72, 52, 28, 255
    @stTip.addChild @lbTip, 0
    @lbTip.attr
      x: @stTip.width / 2 + 120
      y: @stTip.height / 2 + 100
    @addChild @stTip, 0

  ###
  设置进度条的值[0,100]
  ###
  setProgress : (progress) ->
    if progress < 2
      @pbLoading.setPercent 2
    else if progress > 97
      @pbLoading.setPercent 97
    else
      @pbLoading.setPercent progress

  ###
  获取进度条的值
  ###
  getProgress :  ->
    progress = @pbLoading.getPercent()
    if progress < 2
      return 0
    else if progress > 97
      return 100
    return @pbLoading.getPercent()