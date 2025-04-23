class ArticleModel {
  final int id;

  final String title;

  final String? image;

  final String description;
  final String category;
  // final DateTime createDate;
  // final DateTime updateDate;

  ArticleModel(
      {required this.id,
      required this.title,
      required this.image,
      required this.description,
      required this.category,
      // required this.createDate,
      // required this.updateDate
      });

  factory ArticleModel.fromJson(data) {
    return ArticleModel(
      id: data['id'],
      title: data['title'],
      image: data['image'],
      description: data['description'],
      category: data['category'],
      // createDate: DateTime.parse(
      //   data['created_at'],
      // ),
      // updateDate: DateTime.parse(
      //   data['updated_at'],
      // ),
    );
  }
}
