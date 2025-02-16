import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:musically/utilities/constants/constants.dart';
import 'package:musically/utilities/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class NeuBox extends StatelessWidget {
  final Widget? child;

  const NeuBox({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    bool isDarkmode =Provider .of<ThemeProvider>(context).isDarkMode;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: isDarkmode ? black  :  Colors.grey.shade500,
            blurRadius: 15.0,
            offset: Offset(4, 4),
          ),
          BoxShadow(
            color:isDarkmode ?  Colors.grey.shade800  :  white,
            blurRadius: 15.0,
            offset: Offset(-4, -4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: child,
      ),
    );
  }
}
