import 'package:flutter/material.dart';
import 'package:musically/data/models/songs/song_provider.dart';
import 'package:musically/main.dart';
import 'package:musically/utilities/functions/image_picker.dart';
import 'package:musically/utilities/functions/pickaudiofile.dart';
import 'package:musically/utilities/themes/theme_provider.dart';
import 'package:provider/provider.dart';

String? currentUser= getCurrentUserId();



class Providers {
  static Widget setupProviders(Widget child) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ImagePickerService()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => AudioPickerService()),
  ChangeNotifierProvider(create: (context) => Playlistprovider()),
      ],
      child: child, 
    );
  }
}