import 'dart:convert';

import 'package:hrdmagenta/model/coin.dart';
import 'package:http/http.dart' as http;


class ApiHelper {
  getCoins([String url]) async {
    var data = await http.get(url ?? 'https://api.coinlore.net/api/tickers/');
    return Coin.fromMap(json.decode(data.body));
  }

  getApi(int start) {
    final mainUrl = "https://api.coinlore.net/api/tickers/?start=";
    return mainUrl + start.toString() + "&limit=20";
  }
}

final apiHelper = ApiHelper();