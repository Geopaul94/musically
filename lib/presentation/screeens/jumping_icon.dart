import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:musically/utilities/constants/constants.dart';





// class JumpingIcon extends StatefulWidget {
 
//   final Icon iconsdata;
//   final Function()? onTap; // Adding a callback function for file selection

//   const JumpingIcon({Key? key,  required this.iconsdata, this.onTap})
//       : super(key: key);

//   @override
//   JumpingIconState createState() => JumpingIconState();
// }

// class JumpingIconState extends State<JumpingIcon>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 500),
//       vsync: this,
//     );

//     _animation = Tween<double>(begin: 0, end: -20.h).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
//     )..addStatusListener((status) {
//         if (status == AnimationStatus.completed) {
//           _controller.reverse();
//         } else if (status == AnimationStatus.dismissed) {
//           _controller.forward();
//         }
//       });

//     _controller.forward();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         GestureDetector(
//           onTap: widget.onTap, // Use the onTap passed from the parent
//           child: Container(
//             width: 160.w,
//             height: 160.h,
//             decoration: BoxDecoration(
//               color: const Color.fromARGB(62, 71, 69, 69),
//               borderRadius: BorderRadius.circular(15),
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 AnimatedBuilder(
//                   animation: _animation,
//                   builder: (context, child) {
//                     return Transform.translate(
//                         offset: Offset(0, _animation.value),
//                         child:widget.iconsdata,);
//                   },
//                 ),
//          h20, // Replace h20 with SizedBox
//                 // Text(
              
//                 //   style: TextStyle(
//                 //     fontSize: 16.sp,
//                 //     fontWeight: FontWeight.bold,
//                 //   ),
//                 // ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }




class JumpingIcon extends StatefulWidget {
 
  final Icon iconsdata;
  final Function()? onTap; // Adding a callback function for file selection

  const JumpingIcon({Key? key,  required this.iconsdata, this.onTap})
      : super(key: key);

  @override
  JumpingIconState createState() => JumpingIconState();
}

class JumpingIconState extends State<JumpingIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: -20.h).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return 
      
      
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Transform.translate(
                        offset: Offset(0, _animation.value),
                        child:widget.iconsdata,);
                  },
                );
          // Replace h20 with SizedBox
                // Text(
              
                //   style: TextStyle(
                //     fontSize: 16.sp,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
              
            
      
  }
}
