# 自定义输出日志
@LogTool =
  OPENLOGFLAG : true

#正常输出
  c : (logMsg) ->
    if @OPENLOGFLAG
      cc.log "NormalLog : #{logMsg}"

#错误输出
#  e : (errMsg) ->
#    if @OPENLOGFLAG
#      console.error "ErrorLog : #{errMsg}"
#
#  dir : (obj) ->
#    if @OPENLOGFLAG
#      console.dir(obj)



###

  console 一些函数

###

###
console.debug(object[, object, ...])
  在控制台输出一条消息，包含一个指向代码调用位置的超链接。假如是直接在控制台输入该命令，就不会出现超链接（和console.log()一样）。

console.info(object[, object, ...])
  在控制台输出一条带有“信息”图标的消息和一个指向代码调用位置的超链接。

console.warn(object[, object, ...])
  在控制台输出一条带有“警告”图标的消息和一个指向代码调用位置的超链接。

console.error(object[, object, ...])
  在控制台输出一条带有“错误”图标的消息和一个指向代码调用位置的超链接。

console.assert(expression[, object, ...])
  测试表达式expression是否为真。如果不是真，会在控制台写一条消息并抛出异常

console.dir(object)
  以列表形式输出一个对象的所有属性，有点和你查看DOM窗口相类似。

console.dirxml(node)
  输出一个HTML或者XML元素的XML源代码。和你在HTML窗口看到的相似。

console.trace()
  用来追踪函数的调用轨迹。
  Prints an interactive stack trace of JavaScript execution at the point where it is called.
  The stack trace details the functions on the stack, as well as the values that were passed as arguments to each function. You can click each function to take you to its source in the Script tab, and click each argument value to inspect it in the DOM or HTML tabs.

console.group(object[, object, ...])
  输出一条消息，并打开一个嵌套块，块中的内容都会缩进。调用console.groupEnd()关闭块。该命令可以嵌套使用。

console.groupEnd()
  关闭最近一个由console.group打开的块。

console.time(name)
  创建一个名字为name的计时器，调用console.timeEnd(name)停止计时器并输出所耗时间（毫秒）。

console.timeEnd(name)
  停止同名的计时器并输出所耗时间（毫秒）。

console.profile([title])
  打开Javascript性能测试开关。可选参数title会在打印性能测试报告时在报告的开头输出。

console.profileEnd()
  关闭Javascript性能测试开关并输出报告。

console.count([title])
  Writes the number of times that the line of code where count was called was executed. The optional argument title will print a message in addition to the number of the count.
###
