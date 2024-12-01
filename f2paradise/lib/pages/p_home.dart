import 'package:f2paradise/models/game.dart';
import 'package:f2paradise/pages/p_my_list.dart';
import 'package:f2paradise/pages/p_search.dart';
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
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SearchPage(),
              ),
            );
          },
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.search,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Search Games',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return MyListPage(
                  games: [
                    Game(
                      id: 540,
                      title: "Overwatch 2",
                      thumbnail:
                          "https://www.freetogame.com/g/540/thumbnail.jpg",
                      shortDescription:
                          "A hero-focused first-person team shooter from Blizzard Entertainment.",
                      gameUrl: "https://www.freetogame.com/open/overwatch-2",
                      genre: "Shooter",
                      platform: "PC (Windows)",
                      publisher: "Activision Blizzard",
                      developer: "Blizzard Entertainment",
                      releaseDate: "2022-10-04",
                    ),
                    Game(
                      id: 475,
                      title: "Genshin Impact",
                      thumbnail:
                          "https://www.freetogame.com/g/475/thumbnail.jpg",
                      shortDescription:
                          "If you’ve been looking for a game to scratch that open-world action RPG itch, one with perhaps a bit of Asian flair, then you’re going to want to check out miHoYo’s Genshin Impact.",
                      gameUrl: "https://www.freetogame.com/open/genshin-impact",
                      genre: "Action RPG",
                      platform: "PC (Windows)",
                      publisher: "miHoYo",
                      developer: "miHoYo",
                      releaseDate: "2020-09-28",
                    ),
                  ],
                );
              },
            ),
          );
        },
        child: const Icon(Icons.list),
      ),
    );
  }
}
