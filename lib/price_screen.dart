import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'services/rates.dart';

class PriceScreen extends StatefulWidget {
  PriceScreen({
    @required this.rateForBTC,
    @required this.rateForETH,
    @required this.rateForLTC,
  });

  final rateForBTC;
  final rateForETH;
  final rateForLTC;

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = currenciesList.first;
  String returnedBtcRate;
  String returnedEthRate;
  String returnedLtcRate;
  Rates exchangeRate = Rates();
  bool loading = false;

  @override
  void initState() {
    super.initState();
    // updateUI(widget.rates);
    updateUI(
      btcRate: widget.rateForBTC,
      ethRate: widget.rateForETH,
      ltcRate: widget.rateForLTC,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              rateCard(cryptoAsset: 'BTC', cryptoRate: returnedBtcRate),
              rateCard(cryptoAsset: 'ETH', cryptoRate: returnedEthRate),
              rateCard(cryptoAsset: 'LTC', cryptoRate: returnedLtcRate)
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: DropdownButton(
              value: selectedCurrency,
              items:
                  currenciesList.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem(
                  child: Text(value),
                  value: value,
                );
              }).toList(),
              onChanged: (selectedValue) async {
                setState(() {
                  selectedCurrency = selectedValue;
                  debugPrint('selectedCurrency is $selectedCurrency');
                  debugPrint("loading");
                  loading = true;
                });
                var exchangeRateBTC = await exchangeRate.getExchangeRate(
                    cryptoCurrency: 'BTC', fiatCurrency: selectedCurrency);
                var exchangeRateETH = await exchangeRate.getExchangeRate(
                    cryptoCurrency: 'ETH', fiatCurrency: selectedCurrency);
                var exchangeRateLTC = await exchangeRate.getExchangeRate(
                    cryptoCurrency: 'LTC', fiatCurrency: selectedCurrency);

                updateUI(
                  btcRate: exchangeRateBTC,
                  ethRate: exchangeRateETH,
                  ltcRate: exchangeRateLTC,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Padding rateCard({
    @required cryptoAsset,
    @required cryptoRate,
  }) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            loading
                ? 'loading'
                : '1 $cryptoAsset = $cryptoRate $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  void updateUI({
    @required double btcRate,
    @required double ethRate,
    @required double ltcRate,
  }) {
    setState(() {
      if (btcRate == null) {
        returnedBtcRate = 'Unable to get exhange rates';
        return;
      }
      debugPrint('loaded');
      loading = false;
      returnedBtcRate = btcRate.toString();
      returnedEthRate = ethRate.toString();
      returnedLtcRate = ltcRate.toString();
    });
  }
}
