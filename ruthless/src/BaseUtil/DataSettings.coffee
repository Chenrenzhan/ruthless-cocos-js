###
  数据持久化存储到本地
###

cc.loader.loadJson res.setting, (err, json) ->
  if err
    LogTool.c err
  else
    THIS.designWinSize = new cc.p json.designWinSize.width, json.designWinSize.height
    THIS.resolutionPolicy = cc.ResolutionPolicy.SHOW_ALL

    #获取屏幕分辨率
    THIS.winSize = cc.winSize
    LogTool.c "cc.winSize   " + cc.winSize.width + "  " + cc.winSize.height
    #加载资源前延迟时间, 单位秒
    THIS.loadResourceDelay = json.loadResourceDelay
    #加载页面加载完成后停留时间
    THIS.loadFinishDelay = json.loadFinishDelay
    # 下个对话框显示延迟时间
    THIS.nextDialogDelay = json.nextDialogDelay

    #点击对话框遮罩层，是否关闭对话框
    THIS.isCloseDialogOutside = json.isCloseDialogOutside

    # 倒计时时间秒
    THIS.countDown = json.countDown

    # 难度数字范围
    THIS.difficultScope = json.difficultScope
      

    # 经典模式本局最大出错数
    THIS.maxError = json.maxError

    # 控制下落过程是否旋转
    THIS.isRotation = json.isRotation

    # 下滑数字旋转一圈时间
    THIS.rotationTime = json.rotationTime

    # 每一局下落数字数目
    THIS.numberCount = json.numberCount

    # 每一关数字下落加速度
    THIS.accelerometer = json.accelerometer
     
    # 数字下落随机时间范围
    THIS.randomFall = json.randomFall

    # cc.sys.localStorage.getItem 在没有值的情况下，web和native表现不一样，web可以用null来判断，但是native这一条件判断不行

    # 音乐开启关闭
    try
      if not THIS.isEmpty(state = THIS.LS.getItem THIS.MUSIC_STATE)
        THIS.musicState = eval state
    catch error
      LogTool.c error
      THIS.musicState = json.musicState

    # 游戏难度
    try
      if not THIS.isEmpty(difficult = THIS.LS.getItem THIS.GAME_DIFFICULT)
        THIS.gameDifficult = parseInt difficult
    catch error
      LogTool.c error
      THIS.gameDifficult = json.gameDifficult

    # 最高纪录
    try
      if not THIS.isEmpty(classics = THIS.LS.getItem THIS.HIGH_CLASSIC)
        THIS.highestRecord.classics = parseInt classics
      if not THIS.isEmpty(challenge = THIS.LS.getItem THIS.HIGH_CHALLENGE)
        THIS.highestRecord.challenge = parseInt challenge
      if not THIS.isEmpty(arcade = THIS.LS.getItem THIS.HIGH_ARCADE)
        THIS.highestRecord.arcade = parseInt arcade
    catch error
      LogTool.c error
      THIS.highestRecord = json.highestRecord
