import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_search_app/data/data_source/result.dart';
import 'package:image_search_app/domain/model/photo.dart';
import 'package:image_search_app/domain/use_case/get_photos_use_case.dart';
import 'package:image_search_app/presentation/home/home_state.dart';
import 'package:image_search_app/presentation/home/home_ui_event.dart';

class HomeViewModel with ChangeNotifier {
  HomeState _state = HomeState();

  HomeState get state => _state;

  final GetPhotosUseCase getPhotosUseCase;

  final _eventController = StreamController<HomeUiEvent>();
  Stream<HomeUiEvent> get eventStream => _eventController.stream;

  HomeViewModel(this.getPhotosUseCase);

  Future<void> fetch(String query) async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();
    final Result<List<Photo>> result = await getPhotosUseCase.execute(query);

    result.when(
      success: (photos) {
        _state = state.copyWith(photos: photos);
        notifyListeners();
      },
      error: (message) {
        _eventController.add(HomeUiEvent.showSnackBar(message));
      },
    );
    _state = state.copyWith(isLoading: false);
    notifyListeners();
  }
}
