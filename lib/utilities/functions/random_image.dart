  // Function to get a random image from the assets folder
  Future<String> getRandomImageFromAssets() async {
    List<String> assetImages = [
      'assets/1.jpg',
      'assets/2.jpg',
      'assets/3.jpg',
      'assets/4.jpg',
      'assets/5.jpg',
      'assets/6.jpg',
      'assets/7.jpg',
      'assets/8.jpg',
      'assets/9.jpg',
      'assets/10.jpg',
      'assets/11.jpg',
      'assets/12.jpg',
      'assets/13.jpg',
      'assets/14.jpg',
      'assets/15.jpg',
    ];

    assetImages.shuffle();
    return assetImages.first;
  }
