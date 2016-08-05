#-*- coding:utf8 -*-
import cx_Oracle
import os
    
def makedsn( connstr = 'emms227' ):
    '''如果没有发现/号，则认为是读本地的tnsnames中的串,如emms227; 
    或者如下格式： 10.1.4.227:1521/emms'''
    dsn = connstr
    if connstr.find('/') != -1:
        [ip_port,sid] = connstr.split('/')
        [ip,port] = ip_port.split(':')
        dsn = cx_Oracle.makedsn(ip, port, sid)
    return dsn