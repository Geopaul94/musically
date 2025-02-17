import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:musically/data/models/songs/song_model.dart';
import 'package:musically/presentation/bloc/fetchsongs/fetchsongs_bloc.dart';
import 'package:musically/presentation/bloc/playsongs/playsong_controll_bloc.dart';

import 'package:musically/presentation/screeens/authentication/providers/providers.dart';
import 'package:musically/presentation/screeens/home.dart';
import 'package:musically/presentation/screeens/homepage.dart';

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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    int initialIndex = 0; // Set the starting index for songs
    List<SongsModel> songs = []; // Initialize the list of songs with your data

    return ScreenUtilInit(
      designSize: const Size(392, 802),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<FetchSongsBloc>(
              create: (context) => FetchSongsBloc(),
            ),
            // Provider<MusicPlayerBloc>(
            //     create: (_) => MusicPlayerBloc(songs, initialIndex)),
          ],
          child: MaterialApp(
            title: 'Musically',
            theme: Provider.of<ThemeProvider>(context).themeData,
            home: const Homepage(),
            debugShowCheckedModeBanner: false,
          ),
        );
      },
    );
  }
}
