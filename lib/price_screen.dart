import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'services/rates.dart';

class PriceScreen extends StatefulWidget {
  PriceScreen({this.rates});
  final rates;

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = currenciesList.first;
  String displayedRate;
  Rates exchangeRate = Rates();
  bool loading = false;

  @override
  void initState() {
    super.initState();
    updateUI(widget.rates);
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
              // Padding(
              //   padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
              //   child: RateCard('BTC'),
              // ),
              rateCard('BTC'),
              rateCard('ETH'),
              rateCard('LTC'),
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
                var exchangeRateData = await exchangeRate.getExchangeRate(
                    fiatCurrency: selectedCurrency);

                updateUI(exchangeRateData);
                //TODO: get exchangeRates for BTC, ETC, and LTC
              },
            ),
          ),
        ],
      ),
    );
  }

  Padding rateCard(cryptoAsset) {
    // TODO: use setStates change rateForBTC, rateForETH, and rateForLTC instead of just $displayedRate
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
                : '1 $cryptoAsset = $displayedRate $selectedCurrency',
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

  void updateUI(rates) {
    // TODO: use setStates change rateForBTC, rateForETH, and rateForLTC
    setState(() {
      if (rates == null) {
        displayedRate = 'Unable to get exhange rates';
        return;
      }
      debugPrint('loaded');
      loading = false;
      displayedRate = rates.toString();
    });
  }
}
