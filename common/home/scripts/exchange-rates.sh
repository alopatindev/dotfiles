#!/bin/sh

#BTC=$(wget -qO - https://blockchain.info/ticker | jq '.USD.buy')
BTC=$(wget -qO - https://btc-e.nz/api/3/ticker/btc_usd | jq '.btc_usd.last')
USD=$(wget -qO - 'https://free.currencyconverterapi.com/api/v3/convert?q=USD_RUB' | jq '.results.USD_RUB.val')
printf 'B=%.2f U=%.2f\n' ${BTC} ${USD}
