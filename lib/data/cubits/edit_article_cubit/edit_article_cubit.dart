import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'edit_article_state.dart';

class EditArticleCubit extends Cubit<EditArticleState> {
  EditArticleCubit() : super(EditArticleInitial());
}
