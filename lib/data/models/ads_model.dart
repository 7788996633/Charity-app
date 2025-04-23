class AdsModel {
  final int id;

  final String title;

  final String image;

  final String description;

  AdsModel(
      {required this.id,
      required this.title,
      required this.image,
      required this.description});

  factory AdsModel.fromJson(data) {
    return AdsModel(
        id: data['id'],
        title: data['title'],
        image: data['image'],
        description: data['description']);
  }
}
