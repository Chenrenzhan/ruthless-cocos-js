
@BaseLayer = cc.Layer.extend
	_bgFrame: null
	_oktouch: false
	_showbg: false
	_showbgAcion: false

	ctor: ->
		@_super()

		#渲染一个背景层，默认为黑色的半透明的
		if @_showbg
			#背景
			bgFrame = cc.LayerColor cc.color 0,0,0,200
			@addChild bgFrame, 0
			@_bgFrame = bgFrame
			@setAnchorPoint cc.p 0.5, 0.5

			#设置当前层里面所有节点的描点也和该层相同
			@ignoreAnchorPointForPosition false
			@setContentSize THIS.winSize
			@setPosition cc.p THIS.winSize.width/2, THIS.winSize.height/2

		#开启底层不可点击触摸（层以下的UI都不可被点击）
		if this._oktouch
			#点击时间
			cc.eventManager.addListener
				event: cc.EventListener.TOUCH_ONE_BY_ONE,
				swallowTouches: true,
				onTouchBegan: ->
					return true
			, @

		#开启打开窗体是带的特效
		if @._showbgAcion
			self = this
			self.setScale(0.8)
			if self isnt null
				sl = cc.EaseIn.create cc.ScaleTo.create(0.15,1.1), 2
				sl2 = cc.ScaleTo.create 0.15,1
				seq = cc.Sequence sl,sl2
				self.runAction seq

	setUIFile_File : (file) ->
		json = ccs.load file
		json.node
	setUIFile_JSON: (file) ->
		ccs.uiReader.widgetFromJsonFile file

	setBgColor: (color) ->
		@_bgFrame.setColor color

	onEnter : ->
		@_super()

	onExit: ->
		@_super()
