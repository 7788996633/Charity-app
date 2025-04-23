import 'package:baader/data/cubits/show_accepted_suggestions_cubit/show_accepted_suggestions_cubit.dart';
import 'package:baader/data/cubits/suggestions_cubit/suggestions_cubit.dart';
import 'package:baader/presentaion/widgets/custom_loading_indicator.dart';
import 'package:baader/presentaion/widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/suggestion_item.dart';

class SuggestionsScreen extends StatefulWidget {
  const SuggestionsScreen({super.key});

  @override
  State<SuggestionsScreen> createState() => _SuggestionsScreenState();
}

class _SuggestionsScreenState extends State<SuggestionsScreen> {
  @override
  void initState() {
    BlocProvider.of<SuggestionsCubit>(context).getAllSuggestions();
    BlocProvider.of<ShowAcceptedSuggestionsCubit>(context)
        .showAcceptedSuggestions();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarActions: const Text(""),
      appBarTitle: "Suggestions",
      body: BlocBuilder<SuggestionsCubit, SuggestionsState>(
        builder: (context, state) {
          if (state is SuggestionsSuccess) {
            final suggestionsList = state.suggestions;
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text(
                      "Suggestions",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: ListView.builder(
                        itemCount: suggestionsList.length,
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return SuggestionItem(
                            sugg: suggestionsList[index],
                          );
                        },
                      ),
                    ),
                    const Text(
                      "Accepted Suggestions",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: BlocBuilder<ShowAcceptedSuggestionsCubit,
                          ShowAcceptedSuggestionsState>(
                        builder: (context, state) {
                          if (state is ShowAcceptedSuggestionsSuccess) {
                            final acceptedSuggestionsList = state.suggs;
                            return acceptedSuggestionsList.isEmpty
                                ? const Center(
                                    child: Text(
                                      'there is no data.',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 35),
                                    ),
                                  )
                                : ListView.builder(
                                    itemCount: acceptedSuggestionsList.length,
                                    shrinkWrap: true,
                                    physics: const ClampingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return SuggestionItem(
                                        sugg: acceptedSuggestionsList[index],
                                      );
                                    },
                                  );
                          } else if (state is ShowAcceptedSuggestionsFail) {
                            return Column(
                              children: [
                                const Text(
                                  "There is an error:",
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  state.errmsg,
                                  style: const TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return const Center(
                              child: CustomLoadingIndicator(),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is SuggestionsFail) {
            return Column(
              children: [
                const Text(
                  "There is an error:",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  state.errmsg,
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
