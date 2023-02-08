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
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                // child: Text(
                //   '1 BTC = $displayedRate $selectedCurrency',
                //   textAlign: TextAlign.center,
                //   style: TextStyle(
                //     fontSize: 20.0,
                //     color: Colors.white,
                //   ),
                child: loading
                    ? Text('loading')
                    : Text(
                        '1 BTC = $displayedRate $selectedCurrency',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: DropdownButton(
              // needs value and items properties
              value: selectedCurrency,
              // items: [
              //   DropdownMenuItem(
              //     child: Text('USD'),
              //     value: 'USD',
              //   ),
              //   DropdownMenuItem(
              //     child: Text('EUR'),
              //     value: 'EUR',
              //   ),
              //   DropdownMenuItem(
              //     child: Text('GBP'),
              //     value: 'GPB',
              //   ),
              // ],
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
              },
            ),
          ),
        ],
      ),
    );
  }

  void updateUI(rates) {
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
