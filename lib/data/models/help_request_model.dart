class HelpRequestModel {
  final int id;
  final int userId;
  final String description;
  final String city;
  final String street;
  final String neighborhood;
  final int requestStatus;
  final DateTime createDate;

  HelpRequestModel(
      {required this.id,
      required this.userId,
      required this.description,
      required this.city,
      required this.street,
      required this.createDate,

      required this.neighborhood,
      required this.requestStatus});
  factory HelpRequestModel.fromJson(data) {
    return HelpRequestModel(
      id: data['id'],
      userId: data['user_id'],
      description: data['description'],
      city: data['city'],
      street: data['street'],
      neighborhood: data['neighborhood'],
      requestStatus: data['request_status'],
      createDate: DateTime.parse(
        data['created_at'],
      ),

    );
  }
}
