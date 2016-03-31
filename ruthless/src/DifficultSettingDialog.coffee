###
  游戏难度设置对话框
###


@DifficultSettingDialog = Dialog.extend
  lowNormal : null
  lowSelected : null
  middleNormal : null
  middleSelected : null
  highNormal : null
  highSelected : null

  low : null
  middle : null
  high : null

  ctor : ->
    @_super()

    @initSprite()
    @initLow()
    @initMiddle()
    @initHigh()
    @selectDifficult THIS.gameDifficult

  initSprite : ->
    @lowNormal = new cc.Sprite res.igLowNormal
    @lowSelected = new cc.Sprite res.igLowSelected
    @middleNormal = new cc.Sprite res.igMiddleNormal
    @middleSelected = new cc.Sprite res.igMiddleSelected
    @highNormal = new cc.Sprite res.igHighNormal
    @highSelected = new cc.Sprite res.igHighSelected

  initLow : ->
    @low = cc.MenuItemSprite.create @lowNormal, @lowSelected
    @low.attr
      x: @dialogLayer.width / 2
      y: @dialogLayer.height / 4 * 3
    @low.setEnabled true
    @dialogLayer.addChild @low, 5

    @low.setTag THIS.difficult.low
    cc.eventManager.addListener @listener().clone(), @low

  initMiddle : ->
    @middle = cc.MenuItemSprite.create @middleNormal, @middleSelected
    @middle.attr
      x: @dialogLayer.width / 2
      y: @dialogLayer.height / 4 * 2
    @middle.setEnabled true
    @dialogLayer.addChild @middle, 5

    @middle.setTag THIS.difficult.middle
    cc.eventManager.addListener @listener().clone(), @middle

  initHigh : ->
    @high = cc.MenuItemSprite.create @highNormal, @highSelected
    @high.attr
      x: @dialogLayer.width / 2
      y: @dialogLayer.height / 4
    @high.setEnabled true
    @dialogLayer.addChild @high, 5

    @high.setTag THIS.difficult.high
    cc.eventManager.addListener @listener().clone(), @high

  selectDifficult : (difficult)->
    switch difficult
      when THIS.difficult.low then @selectLow()
      when THIS.difficult.middle then @selectMiddle()
      when THIS.difficult.high then @selectHigh()

  selectLow : ->
    THIS.gameDifficult = THIS.difficult.low
    THIS.LS.setItem THIS.GAME_DIFFICULT, THIS.gameDifficult
    @low.selected() if @low?
    @middle.unselected() if @middle?
    @high.unselected() if @high?

  selectMiddle : ->
    THIS.gameDifficult = THIS.difficult.middle
    THIS.LS.setItem THIS.GAME_DIFFICULT, THIS.gameDifficult
    @low.unselected() if @low?
    @middle.selected() if @middle?
    @high.unselected() if @high?

  selectHigh : ->
    THIS.gameDifficult = THIS.difficult.high
    THIS.LS.setItem THIS.GAME_DIFFICULT, THIS.gameDifficult
    @low.unselected() if @low?
    @middle.unselected() if @middle?
    @high.selected() if @high?

  listener : ->
    self = @
    return cc.EventListener.create
      event: cc.EventListener.TOUCH_ONE_BY_ONE,
      swallowTouches: true                   # 设置是否吞没事件，在 onTouchBegan 方法返回 true 时吞没
      onTouchBegan: (touch, event) ->
        # 实现 onTouchBegan 事件回调函数
        target = event.getCurrentTarget()  #获取事件所绑定的 target
        # 获取当前点击点所在相对按钮的位置坐标
        locationInNode = target.convertToNodeSpace touch.getLocation()
        s = target.getContentSize()
        rect = cc.rect 0, 0, s.width, s.height
        if  cc.rectContainsPoint rect, locationInNode        #点击范围判断检测
          return true
        # 返回false，事件不继续传递到onTouchMived和onTouchEnd事件
        return false;

      onTouchEnded: (touch, event) ->
        # 点击事件结束处理
        target = event.getCurrentTarget()
        self.selectDifficult target.getTag()
