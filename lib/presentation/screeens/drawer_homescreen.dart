import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:musically/data/repository/authentication/auth_service.dart';
import 'package:musically/presentation/screeens/authentication/login_page.dart';
import 'package:musically/utilities/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class DrawerHomescreen extends StatelessWidget {
  const DrawerHomescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          DrawerHeader(
              child: Center(
            child: Icon(
              Icons.music_note,
              size: 40.sp,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ))

          // home titile
          ,
          Padding(
            padding:
                EdgeInsets.only(left: 25.sp, right: 25.sp), // Corrected padding
            child: ListTile(
              title: Text('H O M E'),
              leading: Icon(Icons.home), // Use Icon widget for leading
              onTap: () {},
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 25.sp, right: 25.sp),
            child: ListTile(
              title: Text('T H E M E'),
              leading: const Icon(Icons.color_lens),
              trailing: CupertinoSwitch(
                value: Provider.of<ThemeProvider>(context, listen: true)
                    .isDarkMode,
                onChanged: (value) {
                  Provider.of<ThemeProvider>(context, listen: false)
                      .toggletheme();
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 25.sp, right: 25.sp),
            child: ListTile(
              title: Text('P R O F I L E'),
              leading: Icon(Icons.person), // Changed to a more appropriate icon
              onTap: () {
                // Handle profile tap
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 25.sp, right: 25.sp),
            child: ListTile(
              title: Text('L O G O U T'),
              leading: Icon(Icons.person),
              onTap: () {
                _showAlertDialog(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}

void _showAlertDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Logout',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text('Are you sure you want to logout?'),
        actions: <Widget>[
          TextButton(
            child: Text(
              'Cancel',
              style: TextStyle(
                  color: Colors.red), // Optional: Change color for emphasis
            ),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
          TextButton(
            child: Text(
              'Confirm',
              style: TextStyle(
                  color: Colors.blue), // Optional: Change color for emphasis
            ),
            onPressed: () {
              AuthService().signOut();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ));
            },
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      );
    },
  );
}
