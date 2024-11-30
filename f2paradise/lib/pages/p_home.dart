import 'package:f2paradise/models/game.dart';
import 'package:f2paradise/pages/p_game_details.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          side: BorderSide(
              color: Theme.of(context).colorScheme.secondary, width: 2),
        ),
        splashColor: Theme.of(context).colorScheme.primary,
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).colorScheme.secondary,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return GameDetailsScreen(
              game: GameDetails(
                id: 540,
                title: "Overwatch 2",
                thumbnail: "https://www.freetogame.com/g/540/thumbnail.jpg",
                shortDescription:
                    "A hero-focused first-person team shooter from Blizzard Entertainment.",
                gameUrl: "https://www.freetogame.com/open/overwatch-2",
                genre: "Shooter",
                platform: "PC (Windows)",
                publisher: "Activision Blizzard",
                developer: "Blizzard Entertainment",
                releaseDate: "2022-10-04",
              ),
            );
          }));
        },
        child: const Icon(Icons.games),
      ),
    );
  }
}
