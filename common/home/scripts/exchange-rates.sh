#!/bin/sh

BTC=$(wget -qO - https://blockchain.info/ticker | jq -rM '.USD.buy')
#BTC=$(wget -qO - https://btc-e.nz/api/3/ticker/btc_usd | jq -rM '.btc_usd.last')

BCH=$(wget -qO - https://cex.io/api/ticker/BCH/USD | jq -rM '.last')

ETH=$(wget -qO - https://cex.io/api/ticker/ETH/USD | jq -rM '.last')

#XVG=$(wget -qO - 'https://api.coinmarketcap.com/v1/ticker/verge/' | jq -rM '.[0].price_usd')

#USD=$(wget -qO - 'https://free.currencyconverterapi.com/api/v3/convert?q=USD_RUB' | jq -rM '.results.USD_RUB.val')

#FB=$(wget -qO - https://finance.yahoo.com/quote/FB\?p\=FB | pup 'span[data-reactid=35] text{}' | head -n1)

#USD_CITI=$(wget -qO - https://www.citibank.ru/RUGCB/COA/frx/prefxratinq/flow.action | pup 'div[class=cT-columnMVRefCCYS] div[class=wwctrl] label text{}' | head -n18 | tail -n2 | grep -oE '[0-9.]*')

#printf 'B=%.2f/%2.f E=%.2f X=%.2f F=%.2f U=%.2f (%.2f)\n' ${BTC} ${BCH} ${ETH} ${XVG} ${FB} ${USD} ${USD_CITI}
printf 'B=%.2f/%2.f E=%.2f\n' ${BTC} ${BCH} ${ETH}
