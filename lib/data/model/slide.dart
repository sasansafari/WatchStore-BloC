class Slide {
  int id;
  String title;
  String image;

  Slide({
    required this.id,
    required this.title,
    required this.image,
  });

  factory Slide.fromJson(Map<String, dynamic> json) {
    return Slide(
        id: json['id'] as int,
        title: json['title'] as String,
        image: json['image'] as String);
  }
}
