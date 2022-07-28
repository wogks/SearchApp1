class Video {
  final String picture_id;
  final String tags;

  Video({ required this.picture_id, required this.tags});

  factory Video.fromJson(Map<String, dynamic> json){
    return Video(
      picture_id: json['picture_id'] as String,
      tags: json['tags'] as String
      );    
  }
}