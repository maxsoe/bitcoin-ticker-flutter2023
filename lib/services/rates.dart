import 'package:flutter/material.dart';
import 'networking.dart';

class Rates {
  Future<dynamic> getExchangeRate({
    @required String fiatCurrency,
    @required String cryptoCurrency,
  }) async {
    String coinapiURL =
        'https://rest.coinapi.io/v1/exchangerate/$cryptoCurrency/$fiatCurrency';
    String apiKey = '1C613784-530D-4F42-B413-05DE3C07C569';
    NetworkHelper networkHelper = NetworkHelper('$coinapiURL?apikey=$apiKey');
    var result = await networkHelper.getData();
    double exchangeRate = result['rate'];
    debugPrint('$cryptoCurrency = ${exchangeRate.toString()} $fiatCurrency');

    return exchangeRate;
  }
}
