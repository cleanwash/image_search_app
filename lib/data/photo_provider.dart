import 'package:flutter/material.dart';
import 'package:image_search_app/data/api.dart';

class PhotoProvider extends InheritedWidget {
  final PixabayApi api;
  const PhotoProvider({
    super.key,
    required this.api,
    required super.child,
  });

  static PhotoProvider of(BuildContext context) {
    final PhotoProvider? result =
        context.dependOnInheritedWidgetOfExactType<PhotoProvider>();
    assert(result != null, 'No PixabayApi found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(PhotoProvider oldWidget) {
    return oldWidget.api != api;
  }
}
