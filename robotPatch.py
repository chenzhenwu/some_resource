#-*- coding:utf-8 -*-
'''���ļ��ĳ�ʼ�뷨������robotframework���ⲿ�򲹶�,
����δ�����Բ������޸�robotframework�е�����,
�޶�ȫ������������ļ���

������������������Ҳ��һ���ģ�ֻ����ԭ�������п���û���������
    ���磺��ǰ����ʵ��new_method(self,xxx),Ȼ��
            SomeClass.new_method = new_method
ɾ�����������硡del SomeClass.method

���ڷ���ʵ�֣�module�൱���ࣻ
���ڰ��м��࣬������ʽӦ�������Ƶġ�
'''
from robot.api import logger


'''robotframework'''
#���output.xml�е�msg�еĲ������֣������б���ʾ����\uxxxx\uxxxx���������׵�����
from robot.output.xmllogger import XmlLogger
def xmllogger_write_message(self, msg):
    attrs = {'timestamp': msg.timestamp or 'N/A', 'level': msg.level}
    if msg.html:
        attrs['html'] = 'yes'
    ############
    #����һ���Ǵ��patch����Ϣ�У�����ǲ������ֵ���Ϣ������'�ŷָ��󻹰�����\u�Ĵ��������decode����
    if msg.message.startswith('Arguments') and msg.message.find('\u') != -1:
        some_list = msg.message.split("'")
        decode_list = []
        for li in some_list:
            if li.find('\u') != -1:
                try:
                    li = li.decode('unicode-escape')
                except UnicodeDecodeError,e:
                    logger.warn('�Ե����ŷָ����\\uԪ�ز���decode��unicode-escape������')
                    logger.trace('e.__repr__()����ϸ��Ϣ:%s' % e.__repr__())
                    pass
            decode_list.append(li)
        msg.message = "'".join(decode_list)
    #��patch����
    ############
    self._writer.element('msg', msg.message, attrs)
XmlLogger._write_message = xmllogger_write_message


#��� Oracle���ص�ʧ����Ϣ��һ�ѵ�\xNNNN�����ݣ�ԭ����gbk�ı���
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
#���selenium2library�е�ʧ��ʱ�������ļ����м���ʱ�䴮����ֹ���ģ����ʱ�����ϲ����µ��໥����
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
#���HttpLibrary POST�����Զ�encoding��UTF-8������
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

#���HttpLibrary POSTʱ������RF����unicode���µ�msg+=msgʧ������
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


        