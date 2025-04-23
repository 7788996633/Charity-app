class StatistcsModel {
  final int id;
  final int eventId;
  final String description;

  StatistcsModel(
      {required this.id, required this.eventId, required this.description});

  factory StatistcsModel.fromJson(data) {
    return StatistcsModel(
        id: data['id'],
        eventId: data['event_id'],
        description: data['description']);
  }
}
