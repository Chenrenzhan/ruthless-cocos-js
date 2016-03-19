
@BaseLayer = cc.Layer.extend
	_bgFrame: null 
	_oktouch: false 
	_showbg: false
	_showbgAcion: false

	ctor: ->
		@_super()

		#��Ⱦһ�������㣬Ĭ��Ϊ��ɫ�İ�͸����
		if @_showbg
			#����
			bgFrame = cc.LayerColor cc.color 0,0,0,200
			@addChild bgFrame, 0
			@_bgFrame = bgFrame
			@setAnchorPoint cc.p 0.5, 0.5

			#���õ�ǰ���������нڵ�����Ҳ�͸ò���ͬ
			@ignoreAnchorPointForPosition false 
			@setContentSize winSize 
			@setPosition cc.p winSize.width/2, winSize.height/2

		#�����ײ㲻�ɵ�������������µ�UI�����ɱ������
		if this._oktouch
			#���ʱ��
			cc.eventManager.addListener
				event: cc.EventListener.TOUCH_ONE_BY_ONE,
				swallowTouches: true,
				onTouchBegan: ->
					return true
			, @

		#�����򿪴����Ǵ�����Ч
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
		@._bgFrame.setColor color

	onEnter : ->
		@._super()

	onExit: ->
		@._super()
