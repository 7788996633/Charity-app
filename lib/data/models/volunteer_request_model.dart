class VolunteerRequestModel {
  final int id;

  final int userId;
  final String studding;
  final String skills;
  final DateTime volDate;
  final String availableTime;

  VolunteerRequestModel(
      {required this.id,
      required this.userId,
      required this.studding,
      required this.skills,
      required this.volDate,
      required this.availableTime});

  factory VolunteerRequestModel.fromJson(data) {
    return VolunteerRequestModel(
      id: data['id'],
      userId: data['user_id'],
      studding: data['studding'],
      skills: data['skills'],
      volDate: DateTime.parse(
        data['vol_Date'],
      ),
      availableTime: data['availableTime'],
    );
  }
}
