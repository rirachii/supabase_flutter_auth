import 'package:blog/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog/features/auth/presentation/pages/signup_page.dart';
import 'package:blog/features/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LandingPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const LandingPage(),
      );
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppUserCubit, AppUserState, bool>(
      selector: (state) {
        return state is AppUserLoggedIn;
      },
      builder: (context, isLoggedIn) {
        print(isLoggedIn);
        if (isLoggedIn) {
          return const HomePage();
        }
        return const SignupPage();
      },
    );
  }
}
