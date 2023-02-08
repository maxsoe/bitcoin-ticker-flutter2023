import 'package:flutter/material.dart';
import 'networking.dart';

class Rates {
  Future<dynamic> getExchangeRate({String fiatCurrency}) async {
    String coinapiURL =
        'https://rest.coinapi.io/v1/exchangerate/BTC/$fiatCurrency';
    String apiKey = '1C613784-530D-4F42-B413-05DE3C07C569';
    NetworkHelper networkHelper = NetworkHelper('$coinapiURL?apikey=$apiKey');
    var result = await networkHelper.getData();
    double exchangeRate = result['rate'];
    debugPrint('Exchange rate for $fiatCurrency is ${exchangeRate.toString()}');

    return exchangeRate;
  }
}
