class EventRequestModel {
  final int id;
  final int userId;
  final int eventId;
  final int benefit;
  final int volunteering;
  final int requestStatusVol;
  final int requestStatusBen;
  // final DateTime createdAt;
  // final DateTime updatedAt;

  EventRequestModel({
    required this.id,
    required this.userId,
    required this.eventId,
    required this.benefit,
    required this.volunteering,
    required this.requestStatusVol,
    required this.requestStatusBen,
    // required this.createdAt,
    // required this.updatedAt,
  });

  factory EventRequestModel.fromJson(Map<String, dynamic> data) {
    return EventRequestModel(
      id: data['id'],
      userId: data['user_id'],
      eventId: data['event_id'],
      benefit: data['benefit'],
      volunteering: data['volunteering'],
      requestStatusVol: data['request_status_vol'],
      requestStatusBen: data['request_status_ben'],
      // createdAt: DateTime.parse(data['created_at']),
      // updatedAt: DateTime.parse(data['updated_at']),
    );
  }
}
