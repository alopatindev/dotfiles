#!/usr/bin/python3
# coding=utf-8

import sys

def decode(text):
    en="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ;'/"
    ru="аисвуапршолдьтщзйкыегмцчняАИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯжэ."
    result = ''
    for i in range(len(text)):
        if text[i] in en:
            result += ru[en.index(text[i])]
        elif text[i] in ru:
            result += en[ru.index(text[i])]
        else:
            result += text[i]
    return result

if __name__ == '__main__':
    #n = len(sys.argv)

    #if n < 2:
    #    print('syntax %s ghbdtn' % sys.argv[0])
    #    sys.exit(1)

    #s = ''
    #for i in range(1, n - 1):
    #    s += sys.argv[i] + ' '
    #s += sys.argv[n - 1]

    #print(decode(s))
    text = input()
    print(decode(text))
