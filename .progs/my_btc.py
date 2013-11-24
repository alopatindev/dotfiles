#!/usr/bin/python3
# coding=utf8

import json
import sys
import urllib
import urllib.request


class BitcoinInfo:
    API_URL = 'https://blockchain.info/'
    API_BALANCE = 'rawaddr/'
    API_EXCHANGE_RATE = 'ticker'
    MAGIC_BTC_OFFSET = 0.00000001

    def __init__(self, wallet_id, currencies):
        self.wallet_id = wallet_id
        self.update_currency_table()
        self.update_balance()

        buf = ''
        for currency in currencies:
            buf += self.format_balance(currency) + '   '
        print(buf)

    def url_to_json(self, url):
        output = urllib.request.urlopen(url).read().decode()
        return json.loads(output)

    def format_balance(self, currency):
        c_format = self.currency_format(currency)
        if currency == 'BTC':
            return c_format % (self.balance_btc * self.MAGIC_BTC_OFFSET)
        sell = self.convert_amount(self.balance_btc, currency, False)
        buy = self.convert_amount(self.balance_btc, currency, True)
        avarage_amount = (sell + buy) / 2
        return c_format % avarage_amount

    def update_balance(self):
        url = self.API_URL + self.API_BALANCE + self.wallet_id
        jobj = self.url_to_json(url)
        self.balance_btc = jobj['final_balance']

    def update_currency_table(self):
        jobj = self.url_to_json(self.API_URL + self.API_EXCHANGE_RATE)
        self.currency_table = jobj

    def convert_amount(self, btc, currency, buy):
        t = 'buy' if buy else 'sell'
        return (btc * self.currency_table[currency][t]) * self.MAGIC_BTC_OFFSET

    def currency_format(self, currency):
        if currency == 'BTC':
            return '%f BTC'
        c = self.currency_table[currency]
        if currency == 'USD' or currency == 'EUR':
            return c['symbol'] + '%f'
        else:
            return '%f ' + c['symbol']


wallet_id = sys.argv[1]
BitcoinInfo(wallet_id, ('BTC', 'USD', 'RUB'))
print()
