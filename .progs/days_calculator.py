#!/bin/python2
# -*- coding: utf-8 -*-

import sys
from datetime import *
import numpy as np

def str_to_date(text):
    dd, mm, yyyy = (int(i) for i in text.split('.'))
    return date(yyyy, mm, dd)

def days_between(date_from, date_to, calendar):
    dt = date_to - date_from
    days = dt.days if calendar else np.busday_count(date_from, date_to)
    return days + 1

def main(argv):
    if len(argv) < 2:
        print "usage: %s dd.mm.yyyy dd.mm.yyyy" % sys.argv[0]
        return 1

    date_from_str, date_to_str = argv[1], argv[2]
    date_from = str_to_date(date_from_str)
    date_to = str_to_date(date_to_str)

    print "between", date_from_str, date_to_str
    print "calendar days:", days_between(date_from, date_to, calendar=True)
    print "workdays:", days_between(date_from, date_to, calendar=False)

    return 0

sys.exit(main(sys.argv))
