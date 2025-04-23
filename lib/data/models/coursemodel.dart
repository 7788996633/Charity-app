class CourseModel {
  final int id;
  final String name;
  final String url;
  final int discount;
  final String description;

  final String image;

  CourseModel(
      {required this.id,
      required this.name,
      required this.url,
      required this.discount,
      required this.description,
      required this.image});

  factory CourseModel.fromJson(data) {
    return CourseModel(
      id: data['id'],
      name: data['name'],
      url: data['url'],
      discount: data['discount'],
      description: data['description'],
      image: data['image'],
    );
  }
}
