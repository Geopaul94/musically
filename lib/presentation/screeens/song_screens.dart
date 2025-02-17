import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:musically/data/models/songs/song_model.dart';
import 'package:musically/presentation/screeens/songdesign/neu_box.dart';
import 'package:musically/presentation/screeens/songs_upload_screen.dart';
import 'package:musically/presentation/widgets/custom_text.dart';
import 'package:musically/utilities/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SongScreens extends StatelessWidget {
  final List<SongsModel> songs;

  final int currentIndex;

  const SongScreens(
      {super.key, required this.songs, required this.currentIndex});
  String formattime(Duration duration) {
    String twodigitSeconds =
        duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    String formattedtime = "${duration.inMinutes} : $twodigitSeconds";
    return formattedtime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
            padding:
                const EdgeInsets.only(left: 25, right: 25, bottom: 25, top: 10),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, // Adjusts spacing between items
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(CupertinoIcons.back),
                  ),
                  Text(
                    'P L A Y L I S T',
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500), // Customize text style
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SongsUploadScreen(),
                          ));
                    },
                    icon: Icon(CupertinoIcons.music_albums),
                  ),
                ],
              ),
              // SizedBox(
              //   height: 470.h,
              //   child: NeuBox(
              //     child: Column(
              //       children: [
              //         ClipRRect(
              //           borderRadius: BorderRadius.circular(8.r),
              //           child: SizedBox(
              //               height: 370,
              //               width: double.infinity,
              //               child: Image.network(
              //                 songs[currentIndex].imagepath,
              //                 fit: BoxFit.fill,
              //               )),
              //         ),
              //         Padding(
              //           padding: const EdgeInsets.all(15.0),
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               Column(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   CustomText(
              //                     text: songs[currentIndex].songname,
              //                     fontWeight: FontWeight.bold,
              //                     fontSize: 20.sp,
              //                     color: white,
              //                   ),
              //                   Text(
              //                     "currentsong",
              //                     style: TextStyle(
              //                         fontWeight: FontWeight.bold,
              //                         fontSize: 20.sp,
              //                         color: grey100),
              //                   ),
              //                   CustomText(
              //                       text: songs[currentIndex].artistname,
              //                       fontWeight: FontWeight.bold,
              //                       fontSize: 20.sp),
              //                 ],
              //               ),
              //               Icon(
              //                 Icons.favorite,
              //                 color: red,
              //               )
              //             ],
              //           ),
              //         )
              //       ],
              //     ),
              //   ),
              // ),

              SizedBox(
                height: 490.h,
                child: NeuBox(
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: SizedBox(
                          height: 348,
                          width: double.infinity,
                          child: Image.network(
                            songs[currentIndex].imagepath,
                            fit: BoxFit
                                .cover, // Cover ensures no overflow and proper resizing
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(Icons.broken_image,
                                  size: 100,
                                  color:
                                      Colors.grey); // Handle broken image case
                            },
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null)
                                return child; // When done loading
                              return Center(
                                  child:
                                      CircularProgressIndicator()); // Show loading indicator
                            },
                          ),
                        ),
                      ),h30,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal:  10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: songs[currentIndex].songname,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.sp,
                                  color: white,
                                ),
                               
                                CustomText(
                                    text: songs[currentIndex].artistname,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.sp,  color: Colors.grey),
                              ],
                            ),
                            Icon(
                              Icons.favorite,
                              color: red,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),

              h20,
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //  Text(formattime(00)),

                        Icon(Icons.shuffle), Icon(Icons.repeat),

                        // Text(formattime(value.totalDuration)),
                      ],
                    ),
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                        thumbShape:
                            RoundSliderThumbShape(disabledThumbRadius: 0)),
                    child: Slider(
                      min: 0,
                      max: 100,
                      activeColor: blueAccent,
                      value: 50,
                      onChanged: (double double) {},
                      onChangeEnd: (double double) {},
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: NeuBox(
                      child: Icon(Icons.skip_previous),
                    ),
                  ),
                  w20,
                  Expanded(
                    flex: 2,
                    child: NeuBox(
                        child: Icon(Icons.pause
                            //     : Icons.play_arrow),
                            )),
                  ),
                  w20,
                  Expanded(
                    child: NeuBox(
                      child: Icon(Icons.skip_next),
                    ),
                  ),
                  w20,
                ],
              )
            ])),
      ),
    );
  }
}
