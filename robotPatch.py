#-*- coding:utf-8 -*-
'''本文件的初始想法，是在robotframework的外部打补丁,
这样未来可以不用再修改robotframework中的内容,
修订全部集中在这个文件中

新增方法：新增方法也是一样的，只不过原来的类中可能没有这个方法
    例如：　前面先实现new_method(self,xxx),然后
            SomeClass.new_method = new_method
删除方法：例如　del SomeClass.method

对于非类实现，module相当于类；
对于包中加类，操作方式应该是类似的。
'''
from robot.api import logger


'''robotframework'''
#解决output.xml中的msg中的参数部分，中文列表常显示的是\uxxxx\uxxxx，看不明白的问题
from robot.output.xmllogger import XmlLogger
def xmllogger_write_message(self, msg):
    attrs = {'timestamp': msg.timestamp or 'N/A', 'level': msg.level}
    if msg.html:
        attrs['html'] = 'yes'
    ############
    #下面一段是打的patch：消息中，如果是参数部分的消息，且以'号分隔后还包含了\u的串，则进行decode处理
    if msg.message.startswith('Arguments') and msg.message.find('\u') != -1:
        some_list = msg.message.split("'")
        decode_list = []
        for li in some_list:
            if li.find('\u') != -1:
                try:
                    li = li.decode('unicode-escape')
                except UnicodeDecodeError,e:
                    logger.warn('以单引号分隔后的\\u元素部分decode成unicode-escape出错了')
                    logger.trace('e.__repr__()的详细信息:%s' % e.__repr__())
                    pass
            decode_list.append(li)
        msg.message = "'".join(decode_list)
    #打patch结束
    ############
    self._writer.element('msg', msg.message, attrs)
XmlLogger._write_message = xmllogger_write_message


#解决 Oracle返回的失败信息中一堆的\xNNNN的内容，原来是gbk的编码
from robot.utils import unic
def unic(item):
    if isinstance(item, unicode):
        return item
    if isinstance(item, (bytes, bytearray)):
        try:
            #return item.decode('ASCII')
            return item.decode('cp936')
        except UnicodeError:
            return u''.join(chr(b) if b < 128 else '\\x%x' % b
                            for b in bytearray(item))
    try:
        try:
            return unicode(item)
        except UnicodeError:
            return unic(str(item))
    except:
        return _unrepresentable_object(item)
unic.unic = unic


'''Selenim2Library'''
#解决selenium2library中的失败时截屏，文件名中加入时间串，防止大规模并行时截屏合并导致的相互覆盖
from Selenium2Library.keywords._screenshot import _ScreenshotKeywords
import datetime,random,os,robot
def _get_screenshot_paths(self, filename):
    if not filename:
        self._screenshot_index += 1
        # start
        timestr = datetime.datetime.now().strftime('%Y%m%d-%H%M%d-%f')[:-3]
        randstr = random.randint(1,9999)
        filename = 'selenium-screenshot-%s-%d-%d.png' % (timestr,self._screenshot_index,randstr)
        # end
    else:
        filename = filename.replace('/', os.sep)
    logdir = self._get_log_dir()
    path = os.path.join(logdir, filename)
    link = robot.utils.get_link_path(path, logdir)
    return path, link  
_ScreenshotKeywords._get_screenshot_paths = _get_screenshot_paths

'''HttpLibrary'''
#解决HttpLibrary POST包会自动encoding成UTF-8的问题
from HttpLibrary import HTTP
def set_request_body(self, body):
    """
    Set the request body for the next HTTP request.
     Example:
    | Set Request Body           | user=Aladdin&password=open%20sesame |
    | POST                       | /login                              |
    | Response Should Succeed  |                                     |
    """
    logger.info('Request body set to "%s".' % body)
    #self.context.request_body = body.encode("utf-8")
    self.context.request_body = body
HTTP.set_request_body = set_request_body     

#解决HttpLibrary POST时，由于RF传入unicode导致的msg+=msg失败问题
from HttpLibrary.livetest import TestApp
def _do_httplib_request(self, req):
    "Convert WebOb Request to httplib request."
    #headers = dict((name, val) for name, val in req.headers.iteritems())
    headers = dict((str(name), str(val)) for name, val in req.headers.iteritems())
    if req.scheme not in self.conn:
        self._load_conn(req.scheme)
    conn = self.conn[req.scheme]
    conn.request(req.method, req.path_qs, req.body, headers)

    webresp = conn.getresponse()
    res = webtest.TestResponse()
    res.status = '%s %s' % (webresp.status, webresp.reason)
    res.body = webresp.read()
    response_headers = []
    for headername in dict(webresp.getheaders()).keys():
        for headervalue in webresp.msg.getheaders(headername):
            response_headers.append((headername, headervalue))
    res.headerlist = response_headers
    res.errors = ''
    return res
TestApp._do_httplib_request = _do_httplib_request


        