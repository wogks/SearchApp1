import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:lastsearchapp/model/imagemodel.dart';

class ImagePage extends StatefulWidget {
  const ImagePage({Key? key}) : super(key: key);

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  final _controller = TextEditingController();
  String _query = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _query = _controller.text; //질문: 왜이렇게 선언을 하는지?
                      });
                    },
                    child: const Icon(Icons.search),
                  ),
                  hintText: '검색어를 입력하세요',
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FutureBuilder<List<Picture>>(
                  
                  future: getImages(_query), //질문:future부분에 뭘 쓰는건지?
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text('에러가 발생했습니다'),
                      );
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (!snapshot.hasData) {
                      return const Center(
                        child: Text('데이터가 없습니다'),
                      );
                    }

                    final List<Picture> images = snapshot.data!;

                    if (images.isEmpty) {
                      return const Center(
                        child: Text('데이터가 0개입니다'),
                      );
                    }
                    return OrientationBuilder(builder: ((context, orientation) {
                      return GridView(
                      //질문: 함수부분 모름
                      gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      children: images
                          .where((e) => e.tags.contains(_query))
                          .map((Picture image) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            image.previewURL,
                            fit: BoxFit.cover,
                          ),
                        );
                      }).toList(),
                    );
                    }));
                  },
                ), //질문: 이거 왜 쓰는건지?
              ),
            )
          ],
        )
        );
  }
  }
  Future<List<Picture>> getImages(String _query) async {
    Uri url = Uri.parse(
      'https://pixabay.com/api/?key=10711147-dc41758b93b263957026bdadb&q=$_query&image_type=photo'
    );
    http.Response response = await http.get(url);
    print('response status: ${response.statusCode}');

    String jsonString = response.body;
    Map<String, dynamic> json = jsonDecode(jsonString);
    List<dynamic> hits = json['hits'];
    hits.forEach((element) {
      print(element);
    });
    return hits.map((e) => Picture.fromjson(e)).toList();
  }
