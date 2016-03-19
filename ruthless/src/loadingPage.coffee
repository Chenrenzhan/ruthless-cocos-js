#最外层使用@LoadingLayer目的是暴露出变量到window
#参考http://www.lxway.com/289925114.htm

@LoadingLayer = cc.Layer.extend
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
  #progress bar slider sprite
  stSlider: null
  #progress bar
  pbLoading:null

  ctor: ->
    @_super()

    size = cc.winSize

    @stMainBg = new cc.Sprite res.igMainBg
    @stMainBg.attr
      x: size.width / 2,
      y: size.height / 2

    @addChild @stMainBg, 0

    return true;

