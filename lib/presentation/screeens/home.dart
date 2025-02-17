
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import 'package:musically/presentation/screeens/sample/my_audio.dart';

// import 'package:provider/provider.dart';

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   String formatTime(Duration duration) {
//     String twoDigitSeconds =
//         duration.inSeconds.remainder(60).toString().padLeft(2, '0');
//     return "${duration.inMinutes}:${twoDigitSeconds}";
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Audio Player')),
//       body: SafeArea(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Listen to MyAudio and update UI based on state
//             Consumer<MyAudio>(
//               builder: (context, myAudio, child) {
//                 return Column(
//                   children: [
//                     Text(
//                       "Audio State: ${myAudio.audioState}",
//                       style: TextStyle(fontSize: 20),
//                     ),
//                     SizedBox(height: 20),
//                     Text(
//                       "Total Duration: ${formatTime(myAudio.totalDuration!)}",
//                       style: TextStyle(fontSize: 20),
//                     ),
//                     Text(
//                       "Current Position: ${formatTime(myAudio.position!)}",
//                       style: TextStyle(fontSize: 20),
//                     ),
//                   ],
//                 );
//               },
//             ),
//             SizedBox(height: 20),
//             // Play Button
//             ElevatedButton(
//               onPressed: () {
//                 Provider.of<MyAudio>(context, listen: false).playAudio();
//               },
//               child: Text('Play Audio'),
//             ),
//             SizedBox(height: 20),
//             // Pause Button
//             ElevatedButton(
//               onPressed: () {
//                 Provider.of<MyAudio>(context, listen: false).pauseAudio();
//               },
//               child: Text('Pause Audio'),
//             ),
//             SizedBox(height: 20),
//             // Stop Button
//             ElevatedButton(
//               onPressed: () {
//                 Provider.of<MyAudio>(context, listen: false).stopAudio();
//               },
//               child: Text('Stop Audio'),
//             ),
//             SizedBox(height: 20),
//             // Next Button
//             ElevatedButton(
//               onPressed: () {
//                 Provider.of<MyAudio>(context, listen: false).nextSong(context);
//               },
//               child: Text('Next Song'),
//             ),
//             SizedBox(height: 20),
//             // Previous Button
//             ElevatedButton(
//               onPressed: () {
//                 Provider.of<MyAudio>(context, listen: false).previousSong(context);
//               },
//               child: Text('Previous Song'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
