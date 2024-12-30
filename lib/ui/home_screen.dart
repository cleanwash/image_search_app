import 'package:flutter/material.dart';
import 'package:image_search_app/data/api.dart';
import 'package:image_search_app/model/photo.dart';
import 'package:image_search_app/ui/widget/photo_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final api = PixabayApi();
  final _controller = TextEditingController();
  List<Photo> _photos = [];

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          title: Text('이미지 검색 앱', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () async {
                      final photos = await api.fetch(_controller.text);
                      setState(() {
                        _photos = photos;
                      });
                    },
                    icon: Icon(Icons.search),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.all(16),
                itemCount: _photos.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemBuilder: (context, index) {
                  final photo = _photos[index];
                  return PhotoWidget(
                    photo: photo,
                  );
                },
              ),
            )
          ],
        ));
  }
}
