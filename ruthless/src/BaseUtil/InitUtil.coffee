#全局初始化
#需带上@才能被访问到

# 全局this,在为全局变量赋值时使用，因为coffeescript在给全局变量赋值时会把变量当成局部变量来处理
@THIS = @

# 本地存储,本地存储取出的值是字符串，必须可以用eval()转成对象，或者转成相对应的类型
@LS = cc.sys.localStorage

@MUSIC_STATE = "music_state"
@GAME_DIFFICULT = "game_difficult"
@HIGH_CLASSIC = "high_classics"
@HIGH_CHALLENGE = "high_challenge"
@HIGH_ARCADE = "high_arcade"

#设置设计分辨率
@designWinSize = new cc.p 1280, 720
@resolutionPolicy = cc.ResolutionPolicy.SHOW_ALL

#获取屏幕分辨率
@winSize = cc.winSize

#加载资源前延迟时间, 单位秒
@loadResourceDelay = 0.2
#加载页面加载完成后停留时间
@loadFinishDelay = 0.5
# 下个对话框显示延迟时间
@nextDialogDelay = 0.3

#点击对话框遮罩层，是否关闭对话框
@isCloseDialogOutside = true

# 音乐开启关闭
@musicState = false

# 游戏难度 初级--0， 中级--1， 高级--2
@difficult =
  low : 0
  middle : 1
  high : 2
@gameDifficult = @difficult.low

# 游戏模式 , 经典模式--0， 挑战模式--1， 街机模式--2
@gameMode =
  classics : 0
  challenge : 1
  arcade : 2

# 最高纪录
@highestRecord =
  classics : 0
  challenge : 0
  arcade : 0

# 倒计时时间秒
@countDown =
  classics : null # 经典模式下没有倒计时
  challenge : "03:00"
  arcade : "03:00"

# 难度数字范围
@difficultScope =
  low :
    min : 0
    max : 50
  middle :
    min : 0
    max : 100
  high :
    min : -100
    max : 100


# 经典模式本局最大出错数
@maxError = 3

# 控制下落过程是否旋转
@isRotation = false

# 下滑数字旋转一圈时间
@rotationTime = 2

# 选中数字的颜色
@selectedNumberColor = cc.color 25, 200, 25, 255

# 每一局下落数字数目
@numberCount = 6

# 每一关数字下落加速度
@accelerometer =
  low : 0.01
  middle : 0.02
  high : 0.03

# 数字下落随机时间范围
@randomFall = 3

# 判断字符串为空
@isEmpty = (str) ->
  if str isnt null or str isnt "undefined" or str isnt ""
    return true
  else
    return false
