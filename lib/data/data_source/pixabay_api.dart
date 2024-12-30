import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:image_search_app/data/data_source/result.dart';

class PixabayApi {
  final http.Client client;
  static const baseUrl = 'https://pixabay.com/api/';
  static const key = '44774154-395511745d4c3f076effe3295';

  PixabayApi(this.client);

  Future<Result<Iterable>> fetch(String query) async {
    try {
      final result = await client.get(
          Uri.parse('$baseUrl?key=$key&q=$query&image_type=photo&pretty=true'));
      Map<String, dynamic> jsonResponse = jsonDecode(result.body);
      Iterable hits = jsonResponse['hits'];
      return Result.success(hits);
    } catch (e) {
      return const Result.error('네트워크 에러');
    }
  }
}
