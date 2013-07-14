#!/usr/bin/env python2
# -*- coding: utf-8 -*-

import pylast
import sys
import os
from ConfigParser import RawConfigParser
from time import gmtime, strftime
from shutil import move

#API_KEY = "40887e583290b0d8932e3c872ac7aae5"
#API_SECRET = "6605f506e40adf0ad7eb29da94fafa42"
API_KEY = 'f93b732314fb490801795e8f4062c205'
API_SECRET = '7f3f480915d7fcb1d11e42bc2ea71da4'
CONFIG_FILE = os.path.expanduser('~/.laspyt.cfg')
BACKUPS_DIRECTORY = os.path.expanduser('~/backups/')
CONFIG = None
FILE = '/media/CLIP_PLUS/.loved.log'


def load_config():
    global CONFIG
    CONFIG = RawConfigParser()
    CONFIG.read(CONFIG_FILE)
    if not CONFIG.has_option('DEFAULT', 'user'):
        CONFIG.set('DEFAULT', 'user', '')
    if not CONFIG.has_option('DEFAULT', 'password'):
        CONFIG.set('DEFAULT', 'password', '')


def love(songs):
    network = pylast.LastFMNetwork(
        api_key = API_KEY,
        api_secret = API_SECRET,
        username = CONFIG.get('DEFAULT', 'user'),
        password_hash = CONFIG.get('DEFAULT', 'password')
    )

    for artist, title in songs:
        print "%s - %s" % (artist, title)
        track = network.get_track(artist, title)
        track.love()


def get_loved_songs():
    f = open(FILE, 'r')
    ls = f.readlines()
    f.close()
    for i in ls:
        artist, title = i.split('\t')
        yield (artist.strip(), title.strip())


def backup():
    current_datetime = strftime("%Y-%m-%d_%H:%M:%S", gmtime())
    filename = "%s_%s" % (current_datetime, os.path.basename(FILE))
    if not os.path.exists(BACKUPS_DIRECTORY):
        os.mkdir(BACKUPS_DIRECTORY)
    if os.path.isdir(BACKUPS_DIRECTORY):
        move(FILE, os.path.join(BACKUPS_DIRECTORY, filename))
    else:
        print "Didn't backup because %s is not a directory" % BACKUPS_DIRECTORY


load_config()
if os.path.exists(FILE) and os.path.isfile(FILE):
    love(get_loved_songs())
    backup()
