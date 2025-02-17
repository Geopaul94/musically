import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:musically/data/models/songs/song_model.dart';
import 'package:musically/presentation/bloc/fetchsongs/fetchsongs_bloc.dart';
import 'package:musically/presentation/bloc/fetchsongs/fetchsongs_event.dart';
import 'package:musically/presentation/bloc/fetchsongs/fetchsongs_state.dart';
import 'package:musically/presentation/screeens/authentication/login_page.dart';

import 'package:musically/presentation/screeens/drawer_homescreen.dart';
import 'package:musically/presentation/screeens/favaourite_songs.dart';
import 'package:musically/presentation/screeens/jumping_icon.dart';
import 'package:musically/presentation/screeens/song_screens.dart';
import 'package:musically/presentation/screeens/songs_upload_screen.dart';
import 'package:musically/presentation/widgets/CustomElevatedButton.dart';
import 'package:musically/presentation/widgets/custom_text.dart';
import 'package:musically/presentation/widgets/custome_snackbar.dart';
import 'package:musically/presentation/widgets/shimmer_loading.dart';
import 'package:musically/utilities/constants/constants.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String? currentUserId;

  @override
  void initState() {
    super.initState();

    // Fetch the current user ID from Firebase Authentication
    currentUserId = FirebaseAuth.instance.currentUser?.uid;

    // Ensure the Bloc event is triggered only after we fetch the userId
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (currentUserId != null) {
        context.read<FetchSongsBloc>().add(
              FetchSongsInitialEvent(userId: currentUserId!),
            );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print(
        "        =============================       ${currentUserId ?? 'No user logged in'}");

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text("P L A Y L I S T"),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavaouriteSongs(),
                ),
              );
            },
          ),
        ],
      ),
      drawer: DrawerHomescreen(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Divider(
              color: grey100,
              thickness: .5,
            ),
            BlocConsumer<FetchSongsBloc, FetchSongsState>(
              listener: (context, state) {
                if (state is FetchSongsErrorState) {
                  customSnackbar(context, state.error, red);
                }
              },
              builder: (context, state) {
                if (state is FetchSongsLoadingState) {
                  return Container(height: 600,width: 800,   child: ShimmerLoading());
                } else if (state is FetchSongsSuccessState) {
                  final songs = state.songs;

                  print("songs length ====   ${songs.length}");
                  if (songs.isEmpty) {
                    return const Text(
                      "No songs available",
                      style: TextStyle(fontSize: 20),
                    );
                  }
                  return Expanded(
                    child: ListView.builder(
                      itemCount: songs.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) {
                                    return SongScreens(
                                        songs: songs, currentIndex: index);
                                  },
                                ),
                              );
                            },
                            child: CustomSongContainer(song: songs[index]));
                      },
                    ),
                  );
                } else if (state is FetchSongsErrorState) {
                  return Text(
                    "Error loading songs: ${state.error}",
                    style: const TextStyle(color: Colors.red),
                  );
                }

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 200.h,
                    ),
                    JumpingIcon(
                      iconsdata: Icon(
                        CupertinoIcons.music_note_2,
                        size: 50,
                      ),
                    ),
                    h20,
                    const Text('No audio files available, upload your audio'),
                    h20,
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromARGB(52, 58, 57, 57),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SongsUploadScreen(),
                            ),
                          );
                        },
                        child: const Text('Upload'),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// cusotme song container

class CustomSongContainer extends StatelessWidget {
  final SongsModel song;

  const CustomSongContainer({required this.song});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              song.imagepath,
              height: 100.h,
              width: 100.w,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: song.songname,
                fontSize: 24.sp,
                color: white,
              ),
              CustomText(
                text: song.artistname,
                fontSize: 20.sp,
                color: grey,
              ),
            ],
          ),
          Spacer(),
          CircleAvatar(
            radius: 25.r,
            child: Icon(
              Icons.play_arrow,
              size: 30,
            ),
            backgroundColor: const Color.fromARGB(255, 54, 52, 52),
            foregroundColor: white,
          )
        ],
      ),
    );
  }
}
