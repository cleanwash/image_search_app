import 'dart:math';

import 'package:image_search_app/data/data_source/result.dart';
import 'package:image_search_app/domain/model/photo.dart';
import 'package:image_search_app/domain/repository/photo_api_repository.dart';

class GetPhotosUseCase {
  final PhotoApiRepository repository;

  GetPhotosUseCase(this.repository);

  Future<Result<List<Photo>>> execute(String query) async {
    final result = await repository.fetch(query);
    return result.when(
      success: (photos) {
        return Result.success(photos.sublist(0, min(3, photos.length)));
      },
      error: (message) {
        return Result.error(message);
      },
    );
  }
}
