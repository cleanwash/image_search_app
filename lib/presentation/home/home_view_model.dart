import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/data/data_source/result.dart';
import 'package:image_search_app/domain/repository/photo_api_repository.dart';
import 'package:image_search_app/domain/model/photo.dart';
import 'package:image_search_app/presentation/home/home_state.dart';
import 'package:image_search_app/presentation/home/home_ui_event.dart';

class HomeViewModel with ChangeNotifier {
  HomeState _state = HomeState();

  HomeState get state => _state;

  final PhotoApiRepository repository;

  final _eventController = StreamController<HomeUiEvent>();
  Stream<HomeUiEvent> get eventStream => _eventController.stream;

  HomeViewModel(this.repository);

  Future<void> fetch(String query) async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();
    final Result<List<Photo>> result = await repository.fetch(query);

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
