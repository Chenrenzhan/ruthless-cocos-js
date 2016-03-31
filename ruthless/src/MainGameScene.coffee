###
  主游戏页面
###

@MainGameLayer = cc.Layer.extend
  #main bg sprite
  stMainBg: null
  #title sprite
  stTitle : null
  #classics button
  btnClassics: null
  # challenge button
  btnChallenge: null
  # arcade button
  btnArcade: null
  #menu button
  btnMenu: null

  ctor : ->
    @_super()

    if THIS.musicState
      cc.audioEngine.playMusic(res.bgm, true);

    @initMainBg()

    @initTitle()
    @initBtnClassics()
    @initBtnChallenge()
    @initBtnArcade()
    @initBtnMenu()

    return true

  #初始化背景
  initMainBg : ->
    @stMainBg = new cc.Sprite res.igMainBg
    @stMainBg.attr
      x: cc.winSize.width / 2,
      y: cc.winSize.height / 2

    @addChild @stMainBg, 0

  initTitle : ->
    @stTitle = new cc.Sprite res.igTitle
    @stTitle.attr
      x: cc.winSize.width / 2
      y: cc.winSize.height - 130
    @addChild @stTitle, 0

  btnListener : cc.EventListener.create
    event: cc.EventListener.TOUCH_ONE_BY_ONE,
    swallowTouches: true                   # 设置是否吞没事件，在 onTouchBegan 方法返回 true 时吞没
    onTouchBegan: (touch, event) ->
      #实现 onTouchBegan 事件回调函数
      LogTool.c "onTouchBegan"
      target = event.getCurrentTarget()  #获取事件所绑定的 target
      # 获取当前点击点所在相对按钮的位置坐标
      locationInNode = target.convertToNodeSpace touch.getLocation()
      s = target.getContentSize()
      rect = cc.rect target.x, target.y, s.width, s.height
      if  cc.rectContainsPoint rect, locationInNode        #点击范围判断检测
        target.opacity = 180
        return true

        # 返回false，事件不继续传递到onTouchMived和onTouchEnd事件
      return false;
#      return true

    onTouchMoved: (touch, event) ->
      # 触摸移动时触发
      LogTool.c "onTouchMoved"
      target = event.getCurrentTarget()
      delta = touch.getDelta()
      target.x += delta.x
      target.y += delta.y
#      return true

    onTouchEnded: (touch, event) ->
      # 点击事件结束处理
      LogTool.c "onTouchEnded"
      target = event.getCurrentTarget();


  initBtnClassics : ->
    @btnClassics = new ccui.Button()
    @btnClassics.loadTextureNormal res.igBtnClassics, ccui.Widget.LOCAL_TEXTURE
    @btnClassics.setPressedActionEnabled true
    @btnClassics.attr
      x: 230
      y: 330

    self = @
    @btnClassics.setTouchEnabled true
    @addChild @btnClassics, 5
    @btnClassics.addTouchEventListener (touch, event)->
      if event is ccui.Widget.TOUCH_ENDED
        LogTool.c "点击经典模式按钮"
        curScene = cc.director.getRunningScene()
        cc.director.pushScene curScene
        cc.director.runScene new PlayGameScene THIS.gameMode.classics
    , @btnClassics

  initBtnChallenge : ->
    @btnChallenge = new ccui.Button()
    @btnChallenge.loadTextureNormal res.igBtnChallenge, ccui.Widget.LOCAL_TEXTURE
    @btnChallenge.setPressedActionEnabled true
    @btnChallenge.attr
      x: cc.winSize.width / 2
      y: 180

    @btnChallenge.setTouchEnabled true
    @addChild @btnChallenge, 5
    @btnChallenge.addTouchEventListener (touch, event)->
      if event is ccui.Widget.TOUCH_ENDED
        LogTool.c "点击挑战模式按钮"
        curScene = cc.director.getRunningScene()
        cc.director.pushScene curScene
        cc.director.runScene new PlayGameScene THIS.gameMode.challenge
    , @btnChallenge

  initBtnArcade : ->
    @btnArcade = new ccui.Button()
    @btnArcade.loadTextureNormal res.igBtnArcade, ccui.Widget.LOCAL_TEXTURE
    @btnArcade.setPressedActionEnabled true
    @btnArcade.attr
      x: cc.winSize.width - 230
      y: 330

    @btnArcade.setTouchEnabled true
    @addChild @btnArcade, 5
    @btnArcade.addTouchEventListener (touch, event)->
      if event is ccui.Widget.TOUCH_ENDED
        LogTool.c "点击街机模式按钮"
        curScene = cc.director.getRunningScene()
        cc.director.pushScene curScene
        cc.director.runScene new PlayGameScene THIS.gameMode.arcade
    , @btnArcade


  initBtnMenu : ->
    self = @
    @btnMenu = new ccui.Button()
    @btnMenu.loadTextureNormal res.igBtnMenu, ccui.Widget.LOCAL_TEXTURE
    @btnMenu.setPressedActionEnabled true
    @btnMenu.attr
      x: 80
      y: 50

    @btnMenu.setTouchEnabled true
    @addChild @btnMenu, 5
    @btnMenu.addTouchEventListener (touch, event)->
      if event is ccui.Widget.TOUCH_ENDED
        LogTool.c "点击菜单模式按钮"
        menuDialog = new MenuDialog()
        self.addChild menuDialog, 10
    , @btnMenu



@MainGameScene = cc.Scene.extend
  onEnter: ->
    this._super()
    layer = new MainGameLayer()
#    layer.attr
#      x : -cc.winSize.width / 2
#      y : -cc.winSize.height / 2
    @addChild layer
