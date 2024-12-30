import 'dart:convert';

import 'package:image_search_app/model/photo.dart';
import 'package:http/http.dart' as http;

class PixabayApi {
  final baseUrl = 'https://pixabay.com/api/';
  final key = '44774154-395511745d4c3f076effe3295';

  Future<List<Photo>> fetch(String query) async {
    final response = await http.get(
      Uri.parse('$baseUrl?key=$key&q=$query&image_type=photo&pretty=true'),
    );
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    Iterable hits = jsonResponse['hits'];
    return hits.map((e) => Photo.fromJson(e)).toList();
  }
}
