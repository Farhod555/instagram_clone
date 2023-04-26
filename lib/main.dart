import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/pages/auth/signIn_page.dart';
import 'package:instagram_clone/pages/auth/signUP_page.dart';
import 'package:instagram_clone/pages/auth/splash_page.dart';
import 'package:instagram_clone/profile/profile_cubit.dart';
import 'package:instagram_clone/search/search_cubit.dart';
import 'package:instagram_clone/upload/upload_cubit.dart';

import 'pages/MainView.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();

  runApp(
    MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => UploadCubit()),
          BlocProvider(create: (context) => ProfileCubit()),
          BlocProvider(create: (context) => SearchCubit()),
        ],
        child: const MyApp())
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,

      ),
      home: const SplashPage(),
      routes: {
        '/SignInPage' : (context) => const SignInPage(),
        '/SignUpPage' : (context) => const SingUpPage(),
        '/MainView' : (context) => const MainView(),
      },
    );
  }
}