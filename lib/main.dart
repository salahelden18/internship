import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship/core/theme/app_light_theme.dart';
import 'package:internship/screens/announcement/announcement_screen.dart';
import 'package:internship/screens/careerCenter/approved_screens.dart';
import 'package:internship/screens/careerCenter/career_home_screen.dart';
import 'package:internship/screens/careerCenter/cubit/career_cubit.dart';
import 'package:internship/screens/careerCenter/services/career_service.dart';
import 'package:internship/screens/careerCenter/sgk_screen.dart';
import 'package:internship/screens/changePassword/change_password_screen.dart';
import 'package:internship/screens/changePassword/cubit/change_password_cubit.dart';
import 'package:internship/screens/files_screen.dart';
import 'package:internship/screens/home/cubit/home_cubit.dart';
import 'package:internship/screens/home/update_cv_screen.dart';
import 'package:internship/screens/internship_applay_screen.dart';
import 'package:internship/screens/internship_screen.dart';
import 'package:internship/screens/internship_status_screen.dart';
import 'package:internship/screens/job/cubit/job_cubit.dart';
import 'package:internship/screens/job/job_details_screen.dart';
import 'package:internship/screens/job/job_screen.dart';
import 'package:internship/screens/officialLetter/cubit/officialLetterCubit.dart';
import 'package:internship/screens/officialLetter/officailLettersScreen.dart';
import 'package:internship/screens/profile_screen.dart';
import 'package:internship/screens/staticScreens/about_screen.dart';
import 'package:internship/screens/auth/auth_screen.dart';
import 'package:internship/screens/auth/cubit/auth_cubit.dart';
import 'package:internship/screens/auth/cubit/auth_states.dart';
import 'package:internship/screens/home/home_screen.dart';
import 'package:internship/screens/settings/settings_screen.dart';
import 'package:internship/screens/splash_screen.dart';
import 'package:internship/screens/staticScreens/privacy_policy_screen.dart';
import 'package:internship/services/authenticate_service.dart';
import 'package:internship/services/change_password_service.dart';
import 'package:internship/services/data_service.dart';
import 'package:internship/services/job_service.dart';
import 'package:internship/services/official_letter.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting(); // initialize the intl package with default locale

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => AuthCubit(AuthenticateService())..autoLogin()),
        BlocProvider(
          create: (_) => ChangePasswordCubit(
            ChangePasswordService(),
          ),
        ),
        BlocProvider(create: (_) => HomeCubit(DataService())),
        BlocProvider(create: (_) => JobCubit(JobService())),
        BlocProvider(create: (_) => LetterCubit(OfficialLetterService())),
        BlocProvider(create: (_) => CareerCubit(CareerService())),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: lightThemeData,
        home: BlocBuilder<AuthCubit, AuthStates>(
          builder: (context, state) {
            if (state is AuthLoadingState) {
              print('Loading Splash ');
              return const SplashScreen();
            } else if (state is StudentAuthenticatedState) {
              BlocProvider.of<HomeCubit>(context).getData();
              print('Entered the Home');
              return const HomeScreen();
            } else if (state is CareerCenterAuthenticatedState) {
              context.read<CareerCubit>().getAllRequests();
              print('Here');
              return const CareerHomeScreen();
            } else {
              print('Came Here');
              return const AuthScreen();
            }
          },
        ),
        routes: {
          SettingSScreen.routeName: (ctx) => const SettingSScreen(),
          AboutScreen.routeName: (ctx) => const AboutScreen(),
          PrivacyPolicyScreen.routeName: (ctx) => const PrivacyPolicyScreen(),
          HomeScreen.routeName: (ctx) => const HomeScreen(),
          ChangePasswordScreen.routeName: (ctx) => ChangePasswordScreen(),
          AnnouncementScreen.routeName: (ctx) => const AnnouncementScreen(),
          FilesScreen.routeName: (ctx) => const FilesScreen(),
          JobScreen.routeName: (ctx) => const JobScreen(),
          JobDetailsScreen.routeName: (ctx) => const JobDetailsScreen(),
          UpdateCvScreen.routeName: (ctx) => const UpdateCvScreen(),
          ProfileScreen.routeName: (ctx) => const ProfileScreen(),
          InternshipScreen.routeName: (ctx) => const InternshipScreen(),
          InternshipApplayScreen.routeName: (ctx) =>
              const InternshipApplayScreen(),
          InternshipStatusScreen.routeName: (ctx) =>
              const InternshipStatusScreen(),
          OfficailLetterScreen.routeName: (ctx) => const OfficailLetterScreen(),
          ApprovedScreen.routeName: (ctx) => const ApprovedScreen(),
          SgkScreen.routeName: (ctx) => const SgkScreen(),
        },
      ),
    );
  }
}
