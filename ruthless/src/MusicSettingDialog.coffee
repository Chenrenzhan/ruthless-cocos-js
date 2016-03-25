###
  音乐设置对话框
###


@MusicSettingDialog = Dialog.extend
  openNormal : null
  openSelected : null
  closeNormal : null
  closeSelected : null

  open : null
  close : null

  type :
    open : 0
    close : 1

  ctor : ->
    @_super()

    @initSprite()
    @initOpen()
    @initClose()

  initSprite : ->
    @openNormal = new cc.Sprite res.igMusicOpenNormal
    @openSelected = new cc.Sprite res.igMusicOpenSelected
    @closeNormal = new cc.Sprite res.igMusicCloseNormal
    @closeSelected = new cc.Sprite res.igMusicCloseSelected

  initOpen : ->
    @open = cc.MenuItemSprite.create @openNormal, @openSelected
    @open.attr
      x: @dialogLayer.width / 2
      y: @dialogLayer.height / 2 + @open.height / 2 + 25
    @open.setEnabled true
    if THIS.musicState
      @selectOpen()
    else
      @selectClose()
    @dialogLayer.addChild @open, 5

    @open.setTag @type.open
    cc.eventManager.addListener @listener().clone(), @open

  initClose : ->
    @close = cc.MenuItemSprite.create @closeNormal, @closeSelected
    @close.attr
      x: @dialogLayer.width / 2
      y: @dialogLayer.height / 2 - @close.height / 2 - 25
    @close.setEnabled true
    if THIS.musicState
      @selectOpen()
    else
      @selectClose()
    @dialogLayer.addChild @close, 5

    @close.setTag @type.close
    cc.eventManager.addListener @listener().clone(), @close

  selectOpen :  ->
    THIS.musicState = true
    @open.selected() if @open?
    @close.unselected() if @close?
  selectClose :  ->
    THIS.musicState = false
    @open.unselected() if @open?
    @close.selected() if @close?


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
  #        target.opacity = 180
          return true
        # 返回false，事件不继续传递到onTouchMived和onTouchEnd事件
        return false;

  #    onTouchMoved: (touch, event) ->
  #      # 触摸移动时触发
  #      LogTool.c "onTouchMoved"
  #      target = event.getCurrentTarget()
  #      delta = touch.getDelta()
  #      target.x += delta.x
  #      target.y += delta.y

      onTouchEnded: (touch, event) ->
        # 点击事件结束处理
        target = event.getCurrentTarget();
        if target.getTag() is self.type.open
          self.selectOpen()
        else if target.getTag() is self.type.close
          self.selectClose()
