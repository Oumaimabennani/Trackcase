import 'package:flutter/material.dart';
import 'package:trackcase/components/my_drawer.dart';
import 'package:video_player/video_player.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Accueil"),
      ),
      drawer: const MyDrawer(), // Utilisation du tiroir de navigation
      body: Stack(
        children: [
          // Arrière-plan bleu et blanc
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/colis.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Insérez votre vidéo ici
                VideoWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class VideoWidget extends StatefulWidget {
  const VideoWidget({Key? key});

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  int reloadCount = 0;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/vd1.mp4');
    _initializeVideoPlayerFuture = _controller.initialize();

    // Recharger la vidéo lorsqu'elle se termine
    _controller.addListener(() {
      if (_controller.value.position == _controller.value.duration) {
        setState(() {});
      }
    });

    // Recharger la vidéo automatiquement lors de l'initialisation
    _reloadVideo();
  }

  void _reloadVideo() {
    setState(() {
      reloadCount++;
      _controller.seekTo(const Duration(seconds: 0));
      _controller.play(); // Commencez à lire à nouveau après le rechargement
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Stack(
            alignment: Alignment.center,
            children: [
              AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
              if (_controller.value.position == _controller.value.duration)
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: _reloadVideo,
                ),
            ],
          );
        } else {
          return const CircularProgressIndicator(); // Afficher un indicateur de chargement jusqu'à ce que la vidéo soit initialisée
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose(); // Libérer les ressources du contrôleur vidéo lorsque le widget est supprimé
  }
}
