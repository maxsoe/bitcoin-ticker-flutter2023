import 'package:bitcoin_ticker/price_screen.dart';
import 'package:bitcoin_ticker/services/rates.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getExchangeRateData();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void getExchangeRateData() async {
    Rates exchangeRate = Rates();
    var exchangeRateData = await exchangeRate.getExchangeRate();

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return PriceScreen(rates: exchangeRateData);
    }));
  }
}
