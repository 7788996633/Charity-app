class RateModel {
  final int commentId;
  final int commentedUserId;
  final String comment;
  final double rating;

  factory RateModel.fromJson(data) {
    return RateModel(
      commentId: data['comment_id'],
      commentedUserId: data['commentedUserId'],
      comment: data['comment'],
      rating:double.parse(data['rate'].toString(),),
    );
  }

  RateModel(
      {required this.commentId,
      required this.commentedUserId,
      required this.comment,
      required this.rating});
}
