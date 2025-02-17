import 'package:musically/presentation/screeens/authentication/login_page.dart';
import 'package:musically/presentation/screeens/homepage.dart';
import 'package:path/path.dart' as path;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:musically/presentation/bloc/songsupload/songupload_bloc.dart';
import 'package:musically/presentation/widgets/custom_elevated_button.dart';
import 'package:musically/presentation/widgets/custome_snackbar.dart';
import 'package:musically/presentation/widgets/custometextformfield.dart';
import 'package:musically/utilities/constants/constants.dart';
import 'package:musically/utilities/functions/image_picker.dart';
import 'package:musically/utilities/functions/pickaudiofile.dart';
import 'package:provider/provider.dart';

import '../../data/models/songs/song_model.dart';

import '../../data/repository/song_upload.dart';

class SongsUploadScreen extends StatefulWidget {
  const SongsUploadScreen({super.key});

  @override
  State<SongsUploadScreen> createState() => _SongsUploadScreenState();
}

class _SongsUploadScreenState extends State<SongsUploadScreen> {
  String? audioPath;
  String? imagePath;

  bool _isValidAudioUrl(String url) {
    String extension = path.extension(url).toLowerCase();
    return extension == '.mp3' || extension == '.wav';
  }

  @override
  Widget build(BuildContext context) {
    final imagePickerService = Provider.of<ImagePickerService>(context);
    final audioPickerService = Provider.of<AudioPickerService>(context);
    final TextEditingController _songNameController = TextEditingController();
    final TextEditingController _artistNameController = TextEditingController();
    final TextEditingController _audioUrlController = TextEditingController();
    final SongsUpload _songsUpload = SongsUpload();

    return BlocProvider(
      create: (context) => SonguploadBloc(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('U P L O A D   S O N G'),
        ),
        body: BlocListener<SonguploadBloc, SonguploadState>(
          listener: (context, state) {
            if (state is SonguploadSuccessState) { // Clear the fields after successful upload
              _songNameController.clear();
              _artistNameController.clear();
              _audioUrlController.clear();
              audioPath = null;
              imagePath = null;
              customSnackbar(context, 'Song Uploaded Successfully', green);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return Homepage();
              }));
            } else if (state is SonguploadErrorState) {
              customSnackbar(context, state.error, red);
            }
          },
          child: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                Container(
                  child: Lottie.asset(
                    'assets/animation/2.json',
                    height: 200.h,
                  ),
                ),
                h10,
                CustomTextFormField(
                  labelText: 'Song Name',
                  hintText: 'Song Name',
                  icon: Icons.person_outline,
                  controller: _songNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Song Name is required';
                    }
                    return null;
                  },
                ),
                h20,
                CustomTextFormField(
                  labelText: 'Artist Name',
                  hintText: 'Artist Name',
                  icon: Icons.library_music_outlined,
                  controller: _artistNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Artist Name is required';
                    }
                    return null;
                  },
                ),
                h20,
                CustomTextFormField(
                  labelText: 'Song URl',
                  hintText: 'Paste Audio URL (MP3 or WAV)',
                  icon: Icons.music_note,
                  controller: _audioUrlController,
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      if (!_isValidAudioUrl(value)) {
                        return 'Invalid URL. Please provide an MP3 or WAV file.';
                      }
                    }
                    return null;
                  },
                ),
                h20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   // Image Picker
                    Consumer<ImagePickerService>(
                      builder: (context, imageService, child) {
                        return GestureDetector(
                          onTap: () async {
                            await imageService.pickImage(ImageSource.gallery);
                            setState(() {
                              imagePath = imageService.image?.path;
                            });
                          },
                          child: Container(
                            width: 170.w,
                            height: 170.h,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(62, 71, 69, 69),
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            child: imageService.image != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.file(
                                      imageService.image!,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        CupertinoIcons.camera,
                                        size: 50.h,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'Select Image',
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        );
                      },
                    ),
                     Consumer<AudioPickerService>(
                      builder: (context, audioService, child) {
                        return GestureDetector(
                          onTap: () async {
                            await audioService.pickAudioFile();
                            setState(() {
                              audioPath = audioService.audioFilePath;
                            });
                          },
                          child: Container(
                            width: 170.w,
                            height: 170.h,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(62, 71, 69, 69),
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  CupertinoIcons.music_note_2,
                                  size: 45.h,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  audioService.audioFileName != null
                                      ? (audioService.audioFileName!.length > 18
                                          ? '${audioService.audioFileName!.substring(0, 15)}...'
                                          : audioService.audioFileName!)
                                      : 'Select Music File',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    // Conditional color based on file existence
                                    color: audioService.audioFileName != null
                                        ? Colors
                                            .blueAccent // Color when file exists
                                        : Colors
                                            .white, // Color for 'Select Music File'
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                h20,
                BlocBuilder<SonguploadBloc, SonguploadState>(
                  builder: (context, state) {
                    if (state is SonguploadLoadingState) {
                      return Container(child: CircularProgressIndicator());
                    }

                    return CustomGradientButton(
                      width: 250,
                      height: 60,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      gradientColors: const [Colors.blue, Colors.purple],
                      text: 'Upload',
                      onPressed: () async {
                        // Validate inputs
                        if (_songNameController.text.isEmpty ||
                            _artistNameController.text.isEmpty) {
                          customSnackbar(
                            context,
                            'Please fill in all fields.',
                            Colors.red,
                          );
                          return;
                        }

                        if (_audioUrlController.text.isNotEmpty &&
                            audioPath != null) {
                          customSnackbar(
                            context,
                            'Please select either a URL or an audio file, not both.',
                            Colors.red,
                          );
                          return;
                        }

                        if (_audioUrlController.text.isEmpty &&
                            audioPath == null) {
                          customSnackbar(
                            context,
                            'Please select either a URL or an audio file.',
                            Colors.red,
                          );
                          return;
                        }

                        if (_audioUrlController.text.isNotEmpty &&
                            !_isValidAudioUrl(_audioUrlController.text)) {
                          customSnackbar(
                            context,
                            'Invalid URL. Please provide an MP3 or WAV file.',
                            Colors.red,
                          );
                          return;
                        }

                        if (imagePath == null) {
                          customSnackbar(
                            context,
                            'Please select image.',
                            Colors.red,
                          );
                          return;
                        }

                        // Proceed with upload
                        if (_audioUrlController.text.isNotEmpty ||
                            audioPath != null) {
                          context.read<SonguploadBloc>().add(
                                UsersongsUploadEvent(
                                  songs: SongsModel(
                                    songname: _songNameController.text[0]
                                            .toUpperCase() +
                                        _songNameController.text
                                            .substring(1)
                                            .toLowerCase(),
                                    artistname: _artistNameController.text[0]
                                            .toUpperCase() +
                                        _artistNameController.text
                                            .substring(1)
                                            .toLowerCase(),
                                    audiopath:
                                        _audioUrlController.text.isNotEmpty
                                            ? _audioUrlController.text
                                            : audioPath!,
                                    imagepath: imagePath!,
                                    createdAt: DateTime.now().toString(),
                                  ),
                                ),
                              );
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
