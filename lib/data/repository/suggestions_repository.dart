import 'package:baader/data/models/suggestionmodel.dart';
import 'package:baader/data/services/suggestions_services.dart';

class SuggestionsRepository {
  Future<List<SuggestionModel>> showSuggestions() async {
    var suggestionsList = await SuggestionsServices().showSuggestions();
    return suggestionsList.map((e) => SuggestionModel.fromJson(e)).toList();
  }

  Future<List<SuggestionModel>> showAcceptedSuggestions() async {
    var suggestionsList = await SuggestionsServices().showAcceptedSuggestions();
    return suggestionsList.map((e) => SuggestionModel.fromJson(e)).toList();
  }
}
