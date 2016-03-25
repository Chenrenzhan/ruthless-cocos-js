#弹出对话框
@PopDialog = cc.Layer.extend

    listener : null,            #事件对象
    tcLayer : null,             #传进来的layer
    blackLayer : null,          #黑色遮罩
    flag : false,               #如果为真，则代弹窗被关闭掉
    touchbg_flag : false,       #如果为真，当点击黑色背景层的时候，弹窗会关掉. 默认为false,若为true，则存放弹窗的layer必须设置宽高
    isShow : true,              #弹窗一开始是否为可见,默认为true

    ctor: (layer, isShow, touchbg_flag) ->
        @_super()

        #初始化属性
        @setLocalZOrder 10000

        @touchbg_flag = touchbg_flag if typeof touchbg_flag isnt 'undefined'

        @isShow = isShow if typeof isShow isnt "undefined"

        @visible = @isShow

        @tcLayer = layer

        layer.setLocalZOrder(9999)

        @addChild layer

        @initBlackLayer()

    #初始化黑色遮罩
    initBlackLayer: ->
        @blackLayer = new cc.LayerColor cc.color 0,0,0,120
#        LogTool.c "width : #{@blackLayer.width} + ; height : #{@blackLayer.height}"
#        LogTool.c "x : #{@blackLayer.x} + ; y : #{@blackLayer.y}"

        @show() if @isShow

        @addChild @blackLayer

    #添加事件，使弹窗下面的按钮无法点击
    # self 表示的是当前类的this
    addListener:  ->
        self = @
        @listener = cc.EventListener.create({
            event: cc.EventListener.TOUCH_ONE_BY_ONE
            swallowTouches: true
            onTouchBegan: (touch, event) ->
                if self.touchbg_flag
                    x = self.tcLayer.x
                    y = self.tcLayer.y
                    w = self.tcLayer.width
                    h = self.tcLayer.height
                    tx = parseInt touch.getLocation().x
                    ty = parseInt touch.getLocation().y

                    if not (tx >= x and tx <= x + w and ty >= y and ty <= y + h)
                        self.flag = true
                        self.hidden()

                return true

            onTouchEnded: (touch, event) ->
                if self.touchbg_flag and self.flag
                    self.deleteListener()
                    self.flag = false
        })

        cc.eventManager.addListener @listener, @blackLayer

    #删除
    deleteListener: ->
        cc.eventManager.removeListener @listener

    #显示
    show: (fun) ->
        self = @
        @visible = true
        fadeIn = new cc.FadeTo 0.2, 120
        @blackLayer.runAction fadeIn

        @tcLayer.scale = 0
        scaleTo = new cc.scaleTo(0.4, 1).easing(cc.easeElasticOut 0.7)

        func = new cc.CallFunc (e)->
            fun() if typeof fun isnt "undefined"

        seq = new cc.Sequence scaleTo, func
        @tcLayer.runAction seq
        @addListener()

    #隐藏
    hidden: (fun)->
        self = @
        scaleTo = new cc.scaleTo(0.4, 0).easing(cc.easeElasticOut 0.7)

        func = new cc.CallFunc (e) ->
            self.deleteListener()
            self.visible = false
            fun() if typeof fun isnt "undefined"

        seq = new cc.Sequence scaleTo, func
        @tcLayer.runAction seq
        fadeOut = new cc.FadeOut 0.2
        @blackLayer.runAction fadeOut



