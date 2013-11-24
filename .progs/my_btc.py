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

        print('balance: ' + self.format_balance('BTC'))

        space = '\t'
        balance_sell = 'sell:' + space
        balance_buy = 'buy:' + space
        balance_av = 'av:' + space
        rate_sell = ''
        rate_buy = ''
        rate_av = ''
        for currency in currencies:
            if currency != 'BTC':
                balance_sell += self.format_balance(currency, 'sell') + space
                balance_buy += self.format_balance(currency, 'buy') + space
                balance_av += self.format_balance(currency, 'av') + space
                rate_sell += self.format_rate_sell(currency) + space
                rate_buy += self.format_rate_buy(currency) + space
                rate_av += self.format_rate_average(currency) + space
        print(balance_sell)
        print(balance_buy)
        print(balance_av)
        print()
        print('1 BTC rate:')
        print(rate_sell)
        print(rate_buy)
        print(rate_av)
        print()

    def url_to_json(self, url):
        output = urllib.request.urlopen(url).read().decode()
        return json.loads(output)

    def format_balance(self, currency, t='buy'):
        c_format = self.currency_format(currency)
        if currency == 'BTC':
            return c_format % (self.balance_btc * self.MAGIC_BTC_OFFSET)
        sell = self.convert_amount(self.balance_btc, currency, False)
        buy = self.convert_amount(self.balance_btc, currency, True)
        average_amount = (sell + buy) / 2
        if t == 'sell':
            return c_format % sell
        elif t == 'buy':
            return c_format % buy
        else:
            return c_format % average_amount

    def format_rate_buy(self, currency):
        f = self.currency_format(currency)
        buy = self.currency_table[currency]['buy']
        return 'buy: ' + f % buy

    def format_rate_sell(self, currency):
        f = self.currency_format(currency)
        sell = self.currency_table[currency]['sell']
        return 'sell: ' + f % sell

    def format_rate_average(self, currency):
        f = self.currency_format(currency)
        buy = self.currency_table[currency]['buy']
        sell = self.currency_table[currency]['sell']
        av = (buy + sell) / 2.0
        return 'av: ' + f % av

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
            return c['symbol'] + '%.2f'
        else:
            return '%.2f ' + c['symbol']


wallet_id = sys.argv[1]
BitcoinInfo(wallet_id, ('BTC', 'USD', 'RUB'))
