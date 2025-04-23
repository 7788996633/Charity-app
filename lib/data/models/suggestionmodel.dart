class SuggestionModel {
  final int id;
  final int? userId;
  final String? desc;
  final DateTime? date;
  final int status;

  factory SuggestionModel.fromJson(data) {
    return SuggestionModel(
      id: data['id'],
      userId: data['user_id'],
      desc: data['description'],
      date: DateTime.parse(
        data['date'],
      ),
      status: data['suggestion_status'],
    );
  }

  SuggestionModel(
      {required this.id,
      required this.userId,
      required this.desc,
      required this.date,
      required this.status});
}
