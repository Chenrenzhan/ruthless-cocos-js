#全局初始化
#需带上@才能被访问到

# 全局this,在为全局变量赋值时使用，因为coffeescript在给全局变量赋值时会把变量当成局部变量来处理
@THIS = @

#设置设计分辨率
@designWinSize = new cc.p 1280, 720
@resolutionPolicy = cc.ResolutionPolicy.SHOW_ALL

#获取屏幕分辨率
@winSize = cc.winSize

#加载资源前延迟时间, 单位秒
@loadResourceDelay = 0
#加载页面加载完成后停留时间
@loadFinishDelay = 0
# 下个对话框显示延迟时间
@nextDialogDelay = 0.3

#点击对话框遮罩层，是否关闭对话框
@isCloseDialogOutside = true

# 音乐开启关闭
@musicState = true

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
  classics : 23
  challenge : 18
  arcade : 14

# 倒计时时间秒
@countDown =
  classics : 0 # 经典模式下没有倒计时
  challenge : 3
  arcade : 3

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