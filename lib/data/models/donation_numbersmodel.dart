class DonationNumberModel {
  final int phone;

  DonationNumberModel({required this.phone});

  factory DonationNumberModel.fromJson(data) {
    return DonationNumberModel(
      phone: data['phone'],
    );
  }
}
