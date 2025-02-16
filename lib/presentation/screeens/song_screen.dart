import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:musically/data/models/songs/song_model.dart';
import 'package:musically/data/models/songs/song_provider.dart';
import 'package:musically/presentation/screeens/songdesign/neu_box.dart';
import 'package:musically/presentation/screeens/songs_upload_screen.dart';
import 'package:musically/utilities/constants/constants.dart';
import 'package:provider/provider.dart';

class SongScreen extends StatelessWidget {

  const SongScreen({super.key, });

  String formattime(Duration duration) {
    String twodigitSeconds =
        duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    String formattedtime = "${duration.inMinutes} : $twodigitSeconds";
    return formattedtime;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Playlistprovider>(
      builder: (context, value, child) {
// get playlist

        final playlist = value.playlist;

//get current song index
        final currentsong = playlist[value.currentsongIndex ?? 0];

        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 25, right: 25, bottom: 25, top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //  appbar

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
                            fontWeight:
                                FontWeight.w500), // Customize text style
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

                  //album artwork

                  Container(
                    height: 470.h,
                    child: NeuBox(
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.r),
                            child: Container(
                                height: 360,
                                width: double.infinity,
                                child: Image.asset(
                                  currentsong.songimage,
                                  fit: BoxFit.cover,
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      currentsong.songname,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.sp),
                                    ),
                                    Text(currentsong.artistname),
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
                      ), // Correct this path if necessary
                    ),
                  ),
                  //song duration progress
                  h20,

                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            //start time
                            Text(formattime(value.currentDuration)),
                            //shuffle icon
                            Icon(Icons.shuffle),
                            //repeat icon

                            Icon(Icons.repeat),

                            //end time
                            Text(formattime(value.totalDuration)),
                          ],
                        ),
                      ),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                            thumbShape:
                                RoundSliderThumbShape(disabledThumbRadius: 0)),
                        child: Slider(
                          min: 0,
                          max: value.totalDuration.inSeconds.toDouble(),
                          activeColor: blueAccent,
                          value: value.currentDuration.inSeconds.toDouble(),
                          onChanged: (double double) {},
                          onChangeEnd: (double double) {
                            value.seek(Duration(seconds: double.toInt()));
                          },
                        ),
                      )
                    ],
                  )

                  // playback controll
                  ,

                  Row(
                    children: [
                      //skip previous

                      Expanded(
                          child: GestureDetector(
                              onTap: () {
                                value.playPreviousSong();
                              },
                              child: NeuBox(
                                child: Icon(Icons.skip_previous),
                              ))),

                      w20,
                      Expanded(
                          flex: 2,
                          child: GestureDetector(
                              onTap: () {
                                value.pauseOrResume();
                              },
                              child: NeuBox(
                                child: Icon(value.isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow),
                              ))),
                      w20,
                      Expanded(
                          child: GestureDetector(
                              onTap: value.playNextSong,
                              child: NeuBox(
                                child: Icon(Icons.skip_next),
                              )))

                      //play pause

                      //skip forward
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
