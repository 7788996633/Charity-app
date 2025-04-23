class EventModel {
  final int id;
  final String name;
  final String type;
  final DateTime startDate;
  final DateTime endDate;
  final String location;
  final String image;
  final String description;
  final String? targetCategory;

  EventModel(
      {required this.id,
      required this.name,
      required this.type,
      required this.startDate,
      required this.endDate,
      required this.location,
      required this.image,
      required this.description,
      required this.targetCategory,
      });

  factory EventModel.fromJson(data) {
    return EventModel(
      id: data['id'],
      name: data['name'],
      type: data['type'],
      startDate: DateTime.parse(
        data['start_date'],
      ),
      endDate: DateTime.parse(
        data['end_date'],
      ),
      location: data['location'],
      image: data['image'],
      description: data['description'],
      targetCategory: data['targetCategory'],
    );
  }
}
