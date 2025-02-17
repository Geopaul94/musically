import 'package:flutter/material.dart';

import 'package:musically/main.dart';
import 'package:musically/presentation/screeens/authentication/providers/playlist_provider.dart';
import 'package:musically/utilities/functions/image_picker.dart';
import 'package:musically/utilities/functions/pickaudiofile.dart';
import 'package:musically/utilities/themes/theme_provider.dart';
import 'package:provider/provider.dart';



class Providers {
  static Widget setupProviders(Widget child) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ImagePickerService()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => AudioPickerService()),
 // ChangeNotifierProvider(create: (context) => PlaylistProvider()),
      ],
      child: child, 
    );
  }
}