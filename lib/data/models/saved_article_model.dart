class SavedArticleModel {
  final int id;
  final int articleId;

  SavedArticleModel({required this.id, required this.articleId});

  factory SavedArticleModel.fromJson(data) {
    return SavedArticleModel(
      id: data['id'],
      articleId: data['article_id'],
    );
  }
}
