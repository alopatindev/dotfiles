#!/bin/sh

BTC=$(wget -qO - https://blockchain.info/ticker | jq -rM '.USD.buy')
#BTC=$(wget -qO - https://btc-e.nz/api/3/ticker/btc_usd | jq -rM '.btc_usd.last')

BCH=$(wget -qO - https://cex.io/api/ticker/BCH/USD | jq -rM '.last')

USD=$(wget -qO - 'https://free.currencyconverterapi.com/api/v3/convert?q=USD_RUB' | jq -rM '.results.USD_RUB.val')
#FB=$(wget -qO - 'https://query.yahooapis.com/v1/public/yql?q=select+%2A+from+yahoo.finance.quotes+where+symbol+%3D+%22FB%22&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&format=json' | jq -rM '.query.results.quote.LastTradePriceOnly')

USD_CITI=$(wget -qO - https://www.citibank.ru/RUGCB/COA/frx/prefxratinq/flow.action | pup 'div[class=cT-columnMVRefCCYS] div[class=wwctrl] label text{}' | head -n18 | tail -n2 | grep -oE '[0-9.]*')

printf 'B=%.2f/%2.f U=%.2f (%.2f)\n' ${BTC} ${BCH} ${USD} ${USD_CITI}
