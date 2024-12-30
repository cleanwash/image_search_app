import 'dart:convert';

import 'package:image_search_app/data/photo_api_repository.dart';
import 'package:image_search_app/model/photo.dart';
import 'package:http/http.dart' as http;

class PixabayApi implements PhotoApiRepository {
  static const baseUrl = 'https://pixabay.com/api/';
  static const key = '44774154-395511745d4c3f076effe3295';

  @override
  Future<List<Photo>> fetch(String query, {http.Client? client}) async {
    client ??= http.Client();

    final response = await client.get(
      Uri.parse('$baseUrl?key=$key&q=$query&image_type=photo&pretty=true'),
    );
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    Iterable hits = jsonResponse['hits'];
    return hits.map((e) => Photo.fromJson(e)).toList();
  }
}
