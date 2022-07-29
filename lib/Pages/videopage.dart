import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'videoapp.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({Key? key}) : super(key: key);

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  @override
  final _controller = TextEditingController();
  String _query = '';

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
                    _query = _controller.text;
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
            child: FutureBuilder<List<Video>>(
              //질문 이거 왜 쓰는지?
              future: getVideo(_query), //질문:future부분에 뭘 쓰는건지?
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

                final videos = snapshot.data!;

                if (videos.isEmpty) {
                  return const Center(
                    child: Text('데이터가 0개입니다'),
                  );
                }

                return OrientationBuilder(builder: ((context, orientation) {
                  return GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          orientation == Orientation.portrait ? 2 : 3,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    children: videos
                        .where((e) => e.tags.contains(_query))
                        .map((Video video) {
                      return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      VideoApp(video.videos['medium']['url'])),
                            );
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  'https://i.vimeocdn.com/video/${video.pictureId}_${video.thumbnailSize}.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                              ),
                            ],
                          ));
                    }).toList(),
                  );
                }));
              },
            ), //질문: 이거 왜 쓰는건지?
          ),
        )
      ],
    ));
  }

  Future<List<Video>> getVideo(String querys) async {
    Uri url = Uri.parse(
        'https://pixabay.com/api/videos/?key=28871499-c75df118d01f09e96aaf02d60&q=$querys&image_type=photo');
    http.Response response = await http.get(url);
    print('response status: ${response.statusCode}');

    String jsonString = response.body;
    print(jsonString);

    Map<String, dynamic> json = jsonDecode(jsonString);
    List<dynamic> hits = json['hits'];
    hits.forEach((element) {
      print(element);
    });

    return hits.map((e) => Video.fromJson(e)).toList();
  }
}

class Video {
  final String pictureId;
  final String thumbnailSize = '256x166';
  final String tags;
  final Map<String, dynamic> videos;

  Video({
    required this.pictureId,
    required this.tags,
    required this.videos,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      pictureId: json['picture_id'] as String,
      tags: json['tags'] as String,
      videos: json['videos'] as Map<String, dynamic>,
    );
  }
}
