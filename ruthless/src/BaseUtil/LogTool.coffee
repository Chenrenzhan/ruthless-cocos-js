# �Զ��������־
@LogTool =
  OPENLOGFLAG : true

  #�������
  c : (logMsg) ->
    if @OPENLOGFLAG
      console.log "NormalLog : #{logMsg}"

  #�������
  e : (errMsg) ->
    if @OPENLOGFLAG
      console.error "ErrorLog : #{errMsg}"



###

  console һЩ����

###

###
console.debug(object[, object, ...])
  �ڿ���̨���һ����Ϣ������һ��ָ��������λ�õĳ����ӡ�������ֱ���ڿ���̨���������Ͳ�����ֳ����ӣ���console.log()һ������

console.info(object[, object, ...])
  �ڿ���̨���һ�����С���Ϣ��ͼ�����Ϣ��һ��ָ��������λ�õĳ����ӡ�

console.warn(object[, object, ...])
  �ڿ���̨���һ�����С����桱ͼ�����Ϣ��һ��ָ��������λ�õĳ����ӡ�

console.error(object[, object, ...])
  �ڿ���̨���һ�����С�����ͼ�����Ϣ��һ��ָ��������λ�õĳ����ӡ�

console.assert(expression[, object, ...])
  ���Ա��ʽexpression�Ƿ�Ϊ�档��������棬���ڿ���̨дһ����Ϣ���׳��쳣

console.dir(object)
  ���б���ʽ���һ��������������ԣ��е����鿴DOM���������ơ�

console.dirxml(node)
  ���һ��HTML����XMLԪ�ص�XMLԴ���롣������HTML���ڿ��������ơ�

console.trace()
  ����׷�ٺ����ĵ��ù켣��
  Prints an interactive stack trace of JavaScript execution at the point where it is called.
  The stack trace details the functions on the stack, as well as the values that were passed as arguments to each function. You can click each function to take you to its source in the Script tab, and click each argument value to inspect it in the DOM or HTML tabs.

console.group(object[, object, ...])
  ���һ����Ϣ������һ��Ƕ�׿飬���е����ݶ�������������console.groupEnd()�رտ顣���������Ƕ��ʹ�á�

console.groupEnd()
  �ر����һ����console.group�򿪵Ŀ顣

console.time(name)
  ����һ������Ϊname�ļ�ʱ��������console.timeEnd(name)ֹͣ��ʱ�����������ʱ�䣨���룩��

console.timeEnd(name)
  ֹͣͬ���ļ�ʱ�����������ʱ�䣨���룩��

console.profile([title])
  ��Javascript���ܲ��Կ��ء���ѡ����title���ڴ�ӡ���ܲ��Ա���ʱ�ڱ���Ŀ�ͷ�����

console.profileEnd()
  �ر�Javascript���ܲ��Կ��ز�������档

console.count([title])
  Writes the number of times that the line of code where count was called was executed. The optional argument title will print a message in addition to the number of the count.
###
