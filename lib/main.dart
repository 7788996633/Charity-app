import 'package:baader/data/cubits/add_ads_cubit/add_ads_cubit.dart';
import 'package:baader/data/cubits/add_article_cubit/add_article_cubit.dart';
import 'package:baader/data/cubits/add_course_cubit/add_course_cubit.dart';
import 'package:baader/data/cubits/add_donation_number_cubit/add_donation_number_cubit.dart';
import 'package:baader/data/cubits/add_events_cubit/add_events_cubit.dart';
import 'package:baader/data/cubits/add_statistics_cubit/add_statistics_cubit.dart';
import 'package:baader/data/cubits/add_suggestion_cubit/add_suggestion_cubit.dart';
import 'package:baader/data/cubits/articles_cubit/articles_cubit.dart';
import 'package:baader/data/cubits/benifit_requests_cubit/benifit_requests_cubit.dart';
import 'package:baader/data/cubits/change_user_role_cubit/change_user_role_cubit.dart';
import 'package:baader/data/cubits/confirm_help_request_cubit/confirm_help_request_cubit.dart';
import 'package:baader/data/cubits/confirm_suggestion_cubit/confirm_suggestion_cubit.dart';
import 'package:baader/data/cubits/confirm_volunteer_request_cubit/confirm_volunteer_request_cubit.dart';
import 'package:baader/data/cubits/courses_cubit/courses_cubit.dart';
import 'package:baader/data/cubits/delete_ads_cubit/delete_ads_cubit.dart';
import 'package:baader/data/cubits/delete_article_cubit/delete_article_cubit.dart';
import 'package:baader/data/cubits/delete_course_cubit/delete_course_cubit.dart';
import 'package:baader/data/cubits/delete_event_cubit/delete_event_cubit.dart';
import 'package:baader/data/cubits/delete_event_request_cubit/delete_event_request_cubit.dart';
import 'package:baader/data/cubits/delete_help_request_cubit/delete_help_request_cubit.dart';
import 'package:baader/data/cubits/delete_statistic_cubit/delete_statistic_cubit.dart';
import 'package:baader/data/cubits/delete_suggestion_cubit_/delete_suggestion_cubit.dart';
import 'package:baader/data/cubits/delete_volunteer_request_cubit/delete_volunteer_request_cubit.dart';
import 'package:baader/data/cubits/donation_numbers_cubit/donation_numbers_cubit.dart';
import 'package:baader/data/cubits/edit_article_cubit/edit_article_cubit.dart';
import 'package:baader/data/cubits/edit_course_cubit/edit_course_cubit.dart';
import 'package:baader/data/cubits/edit_event_cubit/edit_event_cubit.dart';
import 'package:baader/data/cubits/event_volunteer_request_cubit/event_volunteer_request_cubit.dart';
import 'package:baader/data/cubits/events_cubit/events_cubit.dart';
import 'package:baader/data/cubits/help_request_cubit/help_request_cubit.dart';
import 'package:baader/data/cubits/login_cubit/login_cubit.dart';
import 'package:baader/data/cubits/logout_cubit/logout_cubit.dart';
import 'package:baader/data/cubits/rate_cubit/rate_cubit.dart';
import 'package:baader/data/cubits/register_cubit/register_cubit.dart';
import 'package:baader/data/cubits/save_article_cubit/save_article_cubit.dart';
import 'package:baader/data/cubits/show_accepted_suggestions_cubit/show_accepted_suggestions_cubit.dart';
import 'package:baader/data/cubits/show_ads_cubit/show_ads_cubit.dart';
import 'package:baader/data/cubits/show_article_by_id_cubit/show_article_by_id_cubit.dart';
import 'package:baader/data/cubits/show_event_by_id_cubit/show_event_by_id_cubit.dart';
import 'package:baader/data/cubits/show_help_requests_cubit/show_help_requests_cubit.dart';
import 'package:baader/data/cubits/show_hot_articles_cubit/show_hot_articles_cubit.dart';
import 'package:baader/data/cubits/show_hot_courses_cubit/show_hot_corses_cubit.dart';
import 'package:baader/data/cubits/show_hot_events_cubit/show_hot_events_cubit.dart';
import 'package:baader/data/cubits/show_our_team_cubit/show_our_team_cubit.dart';
import 'package:baader/data/cubits/show_saved_article_cubit/show_saved_article_cubit.dart';
import 'package:baader/data/cubits/show_stat_cubit/show_stat_cubit.dart';
import 'package:baader/data/cubits/show_user_by_id_cubit/show_user_by_id_cubit.dart';
import 'package:baader/data/cubits/show_user_rate_cubit/show_user_rate_cubit.dart';
import 'package:baader/data/cubits/show_users_cubit/show_users_cubit.dart';
import 'package:baader/data/cubits/show_volunteer_requests_cubit/show_volunteer_requests_cubit.dart';
import 'package:baader/data/cubits/subscribe_to_event_cubit/subscribe_to_event_cubit.dart';
import 'package:baader/data/cubits/suggestions_cubit/suggestions_cubit.dart';
import 'package:baader/data/cubits/unsave_article_cubit/unsave_article_cubit.dart';
import 'package:baader/data/cubits/user_cubit/user_cubit.dart';
import 'package:baader/data/cubits/user_role_cubit/user_role_cubit.dart';
import 'package:baader/data/cubits/volunteer_request_cubit/volunteer_request_cubit.dart';
import 'package:baader/presentaion/screens/on_boarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/cubits/confirm_benifit_requests_cubit/confirm_benifit_requests_cubit.dart';
import 'data/cubits/delete_user_account_cubit/delete_user_account_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AddSuggestionCubit(),
        ),
        BlocProvider(
          create: (context) => UnsaveArticleCubit(),
        ),
        BlocProvider(
          create: (context) => DeleteStatisticCubit(),
        ),
        BlocProvider(
          create: (context) => DeleteSuggestionCubit(),
        ),
        BlocProvider(
          create: (context) => EditEventCubit(),
        ),
        BlocProvider(
          create: (context) => DeleteHelpRequestCubit(),
        ),
        BlocProvider(
          create: (context) => ConfirmHelpRequestCubit(),
        ),
        BlocProvider(
          create: (context) => EventVolunteerRequestCubit(),
        ),
        BlocProvider(
          create: (context) => ShowArticleByIdCubit(),
        ),
        BlocProvider(
          create: (context) => ShowHotArticlesCubit(),
        ),
        BlocProvider(
          create: (context) => ShowHotEventsCubit(),
        ),
        BlocProvider(
          create: (context) => ShowHotCorsesCubit(),
        ),
        BlocProvider(
          create: (context) => LogoutCubit(),
        ),
        BlocProvider(
          create: (context) => CoursesCubit(),
        ),
        BlocProvider(
          create: (context) => EditCourseCubit(),
        ),
        BlocProvider(
          create: (context) => EditArticleCubit(),
        ),
        BlocProvider(
          create: (context) => ShowAcceptedSuggestionsCubit(),
        ),
        BlocProvider(
          create: (context) => AddAdsCubit(),
        ),
        BlocProvider(
          create: (context) => DeleteAdsCubit(),
        ),
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => AddCourseCubit(),
        ),
        BlocProvider(
          create: (context) => AddDonationNumberCubit(),
        ),
        BlocProvider(
          create: (context) => DeleteCourseCubit(),
        ),
        BlocProvider(
          create: (context) => UserCubit(
            UserRoleCubit(),
          ),
        ),
        BlocProvider(
          create: (context) => DeleteArticleCubit(),
        ),
        BlocProvider(
          create: (context) => ShowStatCubit(),
        ),
        BlocProvider(
          create: (context) => ShowEventByIdCubit(),
        ),
        BlocProvider(
          create: (context) => AddStatisticsCubit(),
        ),
        BlocProvider(
          create: (context) => ShowAdsCubit(),
        ),
        BlocProvider(
          create: (context) => UserRoleCubit(),
        ),
        BlocProvider(
          create: (context) => BenifitRequestsCubit(),
        ),
        BlocProvider(
          create: (context) => SubscribeToEventCubit(),
        ),
        BlocProvider(
          create: (context) => ShowUserByIdCubit(),
        ),
        BlocProvider(
          create: (context) => ShowSavedArticleCubit(),
        ),
        BlocProvider(
          create: (context) => DeleteUserAccountCubit(),
        ),
        BlocProvider(
          create: (context) => ShowUsersCubit(),
        ),
        BlocProvider(
          create: (context) => DeleteEventRequestCubit(),
        ),
        BlocProvider(
          create: (context) => ConfirmSuggestionCubit(),
        ),
        BlocProvider(
          create: (context) => ShowVolunteerRequestsCubit(),
        ),
        BlocProvider(
          create: (context) => VolunteerRequestCubit(),
        ),
        BlocProvider(
          create: (context) => ChangeUserRoleCubit(),
        ),
        BlocProvider(
          create: (context) => ConfirmEventRequestsCubit(),
        ),
        BlocProvider(
          create: (context) => DonationNumbersCubit(),
        ),
        BlocProvider(
          create: (context) => RegisterCubit(),
        ),
        BlocProvider(
          create: (context) => SuggestionsCubit(),
        ),
        BlocProvider(
          create: (context) => EventsCubit(),
        ),
        BlocProvider(
          create: (context) => RateCubit(),
        ),
        BlocProvider(
          create: (context) => ConfirmVolunteerRequestCubit(),
        ),
        BlocProvider(
          create: (context) => DeleteVolunteerRequestCubit(),
        ),
        BlocProvider(
          create: (context) => HelpRequestCubit(),
        ),
        BlocProvider(
          create: (context) => AddArticleCubit(),
        ),
        BlocProvider(
          create: (context) => ShowHelpRequestsCubit(),
        ),
        BlocProvider(
          create: (context) => ShowOurTeamCubit(),
        ),
        BlocProvider(
          create: (context) => ShowUserRateCubit(),
        ),
        BlocProvider(
          create: (context) => DeleteEventCubit(),
        ),
        BlocProvider(
          create: (context) => ArticlesCubit(),
        ),
        BlocProvider(
          create: (context) => SaveArticleCubit(),
        ),
        BlocProvider(
          create: (context) => AddEventsCubit(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaler: const TextScaler.linear(1),
      ),
      child: const MaterialApp(
        home: OnBoardingScreen(),
      ),
    );
  }
}
