import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:musically/data/models/songs/songS_ample.dart';
import 'package:musically/data/models/songs/song_provider.dart';
import 'package:musically/presentation/screeens/drawer_homescreen.dart';
import 'package:musically/presentation/screeens/song_screen.dart';
import 'package:musically/presentation/widgets/custom_text.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late final dynamic playlistprovider;


  @override
  void initState() {
  
    super.initState();
    playlistprovider=Provider.of<Playlistprovider>(context,listen: false);
  }

//   void gotoSong(int songIndex){
// playlistprovider.currentIndex=songIndex;
// Navigator.push(context, MaterialPageRoute(builder: (context) => SongScreen(),));
//   }
void gotoSong(int songIndex) {
  playlistprovider.currentsongIndex = songIndex; // Corrected here
 Navigator.push(
    context,
    CupertinoPageRoute(
      builder: (context) => SongScreen(),
    ),
  );
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text("P L A Y L I S T"),
      ),
      drawer: DrawerHomescreen(),
      body: Consumer<Playlistprovider>(
        builder: (context, value, child) {
          
final List <SongsAmple>playlist=value.playlist;
          return ListView.builder(itemCount:  playlist.length,itemBuilder:(context, index) {
            
final SongsAmple song =playlist[index];
            return ListTile(title: Text(song.songname),subtitle: Text(song.artistname),leading: Image.asset(song.songimage),onTap: () =>  gotoSong(index)
          
      );
          },);
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomContainerMusic(),
                CustomContainerMusic(),
                CustomContainerMusic(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomContainerMusic extends StatelessWidget {
  const CustomContainerMusic({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/4.jpg',
                  height: 80.h,
                  width: 50.w,
                ),
                SizedBox(
                  width: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(text: 'Geo Paulson'),
                    CustomText(text: 'Hello world'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
