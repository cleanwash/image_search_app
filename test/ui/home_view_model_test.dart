import 'package:flutter_test/flutter_test.dart';
import 'package:image_search_app/data/data_source/result.dart';
import 'package:image_search_app/domain/repository/photo_api_repository.dart';
import 'package:image_search_app/domain/model/photo.dart';
import 'package:image_search_app/domain/use_case/get_photos_use_case.dart';
import 'package:image_search_app/presentation/home/home_view_model.dart';

void main() {
  test('Stream이 잘 동작해야 한다', () async {
    final viewModel = HomeViewModel(GetPhotosUseCase(FakePhotoApiRepository()));

    await viewModel.fetch('apple');
    await viewModel.fetch('iphone');

    final result = fakeJson.map((e) => Photo.fromJson(e)).toList();

    expect(
      viewModel.state.photos,
      emitsInOrder([
        equals([]),
        equals(result),
        equals(result),
      ]),
    );
  });
}

class FakePhotoApiRepository extends PhotoApiRepository {
  @override
  Future<Result<List<Photo>>> fetch(String query) async {
    Future.delayed(Duration(microseconds: 500));

    return Result.success(fakeJson.map((e) => Photo.fromJson(e)).toList());
  }
}

List<Map<String, dynamic>> fakeJson = [
  {
    "id": 1834639,
    "pageURL":
        "https://pixabay.com/photos/apple-red-fruit-food-fresh-ripe-1834639/",
    "type": "photo",
    "tags": "apple, red, fruit",
    "previewURL":
        "https://cdn.pixabay.com/photo/2016/11/18/13/47/apple-1834639_150.jpg",
    "previewWidth": 150,
    "previewHeight": 150,
    "webformatURL":
        "https://pixabay.com/get/gf7b5c5088d88053e72e0e66eb814894cf34e0238fe479cf1ea0af81ae9bdee27bc0eec9469517043ebed0635d61e40d3203bf399022fe456830939755fc02977_640.jpg",
    "webformatWidth": 640,
    "webformatHeight": 640,
    "largeImageURL":
        "https://pixabay.com/get/g2d64f1a32cb12bf2a5ff2f65a10f1b5d899e236e191817aecb024bbfcbc4b558339bc83f92d74f013138d72477ed0c0c59d51d36ead72ff4684173c8bac752bf_1280.jpg",
    "imageWidth": 2827,
    "imageHeight": 2827,
    "imageSize": 1022194,
    "views": 171854,
    "downloads": 113765,
    "collections": 10396,
    "likes": 291,
    "comments": 68,
    "user_id": 2286921,
    "user": "Pexels",
    "userImageURL":
        "https://cdn.pixabay.com/user/2016/03/26/22-06-36-459_250x250.jpg"
  },
  {
    "id": 256261,
    "pageURL":
        "https://pixabay.com/photos/apple-books-still-life-fruit-food-256261/",
    "type": "photo",
    "tags": "apple, books, still life",
    "previewURL":
        "https://cdn.pixabay.com/photo/2014/02/01/17/28/apple-256261_150.jpg",
    "previewWidth": 150,
    "previewHeight": 99,
    "webformatURL":
        "https://pixabay.com/get/g8f6d42a5b025f97b567c02a5df38d477a185dfe488bd14d5b95d7df8255d4bc59794ce7c2eaf5ac4a0ffa88c225c76b5_640.jpg",
    "webformatWidth": 640,
    "webformatHeight": 423,
    "largeImageURL":
        "https://pixabay.com/get/g36fdc28518b1e7131deed03881352a88c257ca24c1d0fff57d24eb8bfd665052b518cba6ada806c291b4c304ce2b41e24a6eee19a9dfeab0a8783d0f66cbd003_1280.jpg",
    "imageWidth": 4928,
    "imageHeight": 3264,
    "imageSize": 2987083,
    "views": 610086,
    "downloads": 344635,
    "collections": 11913,
    "likes": 1067,
    "comments": 256,
    "user_id": 143740,
    "user": "jarmoluk",
    "userImageURL":
        "https://cdn.pixabay.com/user/2019/09/18/07-14-26-24_250x250.jpg"
  }
];
