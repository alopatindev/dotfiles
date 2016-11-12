#!/usr/bin/python3
# coding=utf8

from BeautifulSoup import BeautifulSoup
import urllib.request
import sys

URL = 'http://www.foreca.ru/Russia/Saint_Petersburg'

text = urllib.request.urlopen(URL).read()
soap = BeautifulSoup(text)

tags = soap.find('div', {'class' : 'wrap-area entry-content'}).find('div', {'class' : 'wrap-area-bot'}).find('div', {'class' : 'table t_cond'}).find('div', {'class' : 'c1'}).find('div', {'class' : 'left'})

print('Санкт-Петербург: ' + tags.find('img', {'class' : 'symb'})['title'] + ',',
      tags.find('strong').string,
      '°С')
sys.stdout.flush()
