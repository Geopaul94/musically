import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:musically/data/models/songs/song_model.dart';
import 'package:musically/presentation/screeens/sample/my_audio.dart';
import 'package:musically/presentation/screeens/songdesign/neu_box.dart';
import 'package:musically/presentation/screeens/songs_upload_screen.dart';
import 'package:musically/presentation/widgets/custom_text.dart';
import 'package:musically/utilities/constants/constants.dart';
class SongScreens extends StatefulWidget {
  final List<SongsModel> songs;
  final int currentIndex;

  const SongScreens(
      {super.key, required this.songs, required this.currentIndex});

  @override
  State<SongScreens> createState() => _SongScreensState();
}

class _SongScreensState extends State<SongScreens> {
  late int currentSongIndex;
  late MyAudio myAudio; // Reference to the audio controller
  double sliderValue = 0.0;

  @override
  void initState() {
    super.initState();
    currentSongIndex = widget.currentIndex;
    myAudio = MyAudio(); // Initialize audio controller
    playCurrentSong(); // Play the current song on screen load
  }

  void playCurrentSong() {
    // Play the song using MyAudio
    myAudio.playAudio(widget.songs[currentSongIndex].audiopath);
  }

  void stopCurrentSong() {
    myAudio.stopAudio(); // Stop the current song
  }

  void nextSong() {
    stopCurrentSong(); // Stop current song before switching
    setState(() {
      if (currentSongIndex < widget.songs.length - 1) {
        currentSongIndex++;
      } else {
        // Show Snackbar when it's the last song
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Last song reached, starting from the first")),
        );
        currentSongIndex = 0; // Loop to the first song
      }
    });
    playCurrentSong(); // Play the next song
  }

  void previousSong() {
    stopCurrentSong(); // Stop current song before switching
    setState(() {
      if (currentSongIndex > 0) {
        currentSongIndex--;
      } else {
        // Show Snackbar when it's the first song
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("First song reached, playing last song")),
        );
        currentSongIndex = widget.songs.length - 1; // Loop to the last song
      }
    });
    playCurrentSong(); // Play the previous song
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25, top: 10),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            // Song cover, title, and artist
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
                          widget.songs[currentSongIndex].imagepath,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.broken_image, size: 100, color: Colors.grey);
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(child: CircularProgressIndicator());
                          },
                        ),
                      ),
                    ),
                    // Song title and artist name
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: widget.songs[currentSongIndex].songname,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.sp,
                                color: Colors.white,
                              ),
                              CustomText(
                                  text: widget.songs[currentSongIndex].artistname,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.sp,
                                  color: Colors.grey),
                            ],
                          ),
                          Icon(Icons.favorite, color: Colors.red),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            // Slider and duration
            Slider(
              value: sliderValue,
              activeColor: Colors.blueAccent,
              onChanged: (value) {
                setState(() {
                  sliderValue = value;
                  // Add seek functionality
                  myAudio.audioPlayer.seek(Duration(seconds: value.toInt()));
                });
              },
              min: 0,
              max: myAudio.totalDuration?.inSeconds.toDouble() ?? 1,
            ),

            // Song controls (previous, play/pause, next)
            Row(
              children: [
                Expanded(
                  child: NeuBox(
                    child: IconButton(
                      icon: Icon(Icons.skip_previous),
                      onPressed: previousSong,
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  flex: 2,
                  child: NeuBox(
                    child: IconButton(
                      icon: myAudio.audioState == "Playing"
                          ? Icon(Icons.pause)
                          : Icon(Icons.play_arrow),
                      onPressed: () {
                        if (myAudio.audioState == "Playing") {
                          myAudio.pauseAudio();
                        } else {
                          playCurrentSong();
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: NeuBox(
                    child: IconButton(
                      icon: Icon(Icons.skip_next),
                      onPressed: nextSong,
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
