#-*- coding:utf-8 -*- 
import lxml.etree


def xmlToString(element, encoding = 'UTF-8' ):
    xmlstr = lxml.etree.tostring( element, 
                    encoding=encoding,
                    method='xml',
                    xml_declaration = True, 
                    pretty_print = True,
                    with_comments=True,
                    )
    return xmlstr
