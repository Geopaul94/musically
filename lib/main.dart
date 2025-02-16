import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:musically/presentation/screeens/audio_upload_screen.dart';
import 'package:musically/presentation/screeens/authentication/login_page.dart';
import 'package:musically/presentation/screeens/authentication/providers/providers.dart';
import 'package:musically/presentation/screeens/authentication/signup_page.dart';
import 'package:musically/presentation/screeens/homepage.dart';
import 'package:musically/presentation/screeens/songs_upload_screen.dart';

import 'package:musically/presentation/screeens/splash_screen.dart';

import 'package:musically/utilities/themes/theme_provider.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    // Providing ThemeProvider for the entire app
      Providers.setupProviders(MyApp()),
  );
}

    String? getCurrentUserId() {
  final user = FirebaseAuth.instance.currentUser;
  return user?.uid;
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {



    return ScreenUtilInit(
      designSize: const Size(392, 802), 
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Musically',
          theme: Provider.of<ThemeProvider>(context).themeData,
          home:SplashScreen(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
