import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: const Color(0xff6750a4), useMaterial3: true
      ),
      home: const YnofifySFW()
    );
  }
}

class YnofifySFW extends StatefulWidget {
  const YnofifySFW({Key? key}) : super(key: key);

  @override
  State<YnofifySFW> createState() => _YnofifySFWState();
}

class _YnofifySFWState extends State<YnofifySFW> with TickerProviderStateMixin {
  final player = AudioPlayer();
  Duration duration = new Duration(seconds: 0);

  int currentMusic = 0;
  bool play = false;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    initSong(myMusicList[0].urlSong);
    _controller = AnimationController(duration: const Duration(seconds: 1), vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
          title: const Text('Ynofify'),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          foregroundColor: const Color.fromARGB(255, 255, 255, 255)),
      body: Column(
        children: <Widget>[
          Image.network(myMusicList[currentMusic].imagePath,
              width: 320.0, height: 320.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 320,
              height: 30,
              child: Text(
                  textAlign: TextAlign.center,
                  myMusicList[currentMusic].singer,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 20.0)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 320,
              height: 50,
              child: Text(
                  textAlign: TextAlign.center,
                  myMusicList[currentMusic].title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 20.0)),
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            leftButton(),
            playButton(),
            rightButton(),
          ]),
          songDuration(),
          
        ],
      ),
    );
  }

  Widget leftButton() {
    return Material(
      color: const Color.fromARGB(255, 0, 0, 0),
      child: Center(
        child: IconButton(
          icon: const Icon(Icons.skip_previous),
          iconSize: 35,
          color: const Color.fromARGB(255, 255, 255, 255),
          onPressed: () {
            if (currentMusic > 0) {
              setState(() {
                currentMusic = currentMusic - 1;
                initSong(myMusicList[currentMusic].urlSong);
              });
            } else {
              setState(() {
                currentMusic = myMusicList.length - 1;
                initSong(myMusicList[currentMusic].urlSong);
              });
            }
          },
        ),
      ),
    );
  }

  Widget rightButton() {
    return Material(
      color: const Color.fromARGB(255, 0, 0, 0),
      child: Center(
        child: IconButton(
          icon: const Icon(Icons.skip_next),
          iconSize: 35,
          color: const Color.fromARGB(255, 255, 255, 255),
          onPressed: () {
            
            if (currentMusic < myMusicList.length - 1) {
              setState(() {
                currentMusic = currentMusic + 1;
                initSong(myMusicList[currentMusic].urlSong);
              });
            } else {
              setState(() {
                currentMusic = 0;
                initSong(myMusicList[currentMusic].urlSong);
              });
            }
          },
        ),
      ),
    );
  }

  Widget playButton() {
    return Material(
      color: const Color.fromARGB(255, 0, 0, 0),
      child: Center(
        child: GestureDetector(
            onTap: () {
              if (play == false) {
                _controller.forward();
                setState(() {
                  play = true;
                });
                playMusic();
              } else {
                _controller.reverse();
                setState(() {
                  play = false;
                });
                pauseMusic();
              }
            },
          child: AnimatedIcon(
            icon: AnimatedIcons.play_pause,
            progress: _controller,
            size: 60,
            color: Colors.white,
              
          ),
        ),
      ),
    );
  }

  Widget songDuration() {
    
      return Center(
        child: Text(
          duration.toString(),
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 20.0)
            ),
      );
  }

  Future<void> initSong(String urlSong) async {
    await player.setAudioSource(
        AudioSource.uri(Uri.parse(myMusicList[currentMusic].urlSong))
    ).then((value) => {
      setState(() {
        duration = value!;
      })
    });
  }

  Future playMusic() async {
    player.play();
  }

  Future pauseMusic() async {
    await player.pause();
  }
  
}

// alexandrevallet69@gmail.com