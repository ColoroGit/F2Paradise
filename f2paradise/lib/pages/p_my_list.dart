import 'dart:io';

import 'package:f2paradise/models/game.dart';
import 'package:f2paradise/pages/p_game_details.dart';
import 'package:f2paradise/utils/database_helper.dart';
import 'package:flutter/material.dart';

class MyListPage extends StatefulWidget {
  const MyListPage({super.key});

  @override
  State<StatefulWidget> createState() => _MyListPageState();
}

class _MyListPageState extends State<MyListPage> {
  final DatabaseHelper db = DatabaseHelper();

  List<String> appliedFilters = [];
  List<String> availableFilters = [
    /*  */
    'Played',
    'Yet to play',
    'Like',
    'Dislike',
    'PC (Windows)',
    'Browser',
    'Shooter',
    'Anime',
    'Battle Royale',
    'MOBA',
    'MMO',
    'MMORPG',
    'Racing',
    'Sports',
    'Fighting',
    'Strategy',
    'Card Game',
    'Simulation',
    'Social',
  ];

  String searchQuery = '';

  List<Game> games = [];
  List<Game> filteredGames = [];

  @override
  void initState() {
    super.initState();
    _loadGames();
  }

  Future<void> _loadGames() async {
    await Future.delayed(const Duration(milliseconds: 500));
    final gamesFromDb = await db.getAllGames();
    setState(() {
      games = gamesFromDb;
      _filterGames();
    });
  }

  void _filterGames() {
    setState(() {
      filteredGames = games.where((game) {
        bool matchesFilters = appliedFilters.isEmpty ||
            appliedFilters.every((filter) {
              if (filter == 'Played') return game.played == 1;
              if (filter == 'Yet to play') return game.played == -1;
              if (filter == 'Like') return game.like == 1;
              if (filter == 'Dislike') return game.like == -1;
              return game.platform.contains(filter) ||
                  game.publisher.contains(filter) ||
                  game.developer.contains(filter);
            });

        bool matchesSearchQuery = searchQuery.isEmpty ||
            game.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
            game.publisher.toLowerCase().contains(searchQuery.toLowerCase()) ||
            game.developer.toLowerCase().contains(searchQuery.toLowerCase());

        return matchesFilters && matchesSearchQuery;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        title: const Text("My Games"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Search',
                  labelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.filter_list,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        context: context,
                        builder: (context) {
                          return ListView(
                            children: availableFilters.map((filter) {
                              return ListTile(
                                title: Text(filter,
                                    style:
                                        const TextStyle(color: Colors.white)),
                                onTap: () {
                                  setState(() {
                                    if (!appliedFilters.contains(filter)) {
                                      appliedFilters.add(filter);
                                    }
                                  });
                                  Navigator.pop(context);
                                  _filterGames();
                                },
                              );
                            }).toList(),
                          );
                        },
                      );
                    },
                  ),
                  fillColor: Theme.of(context).colorScheme.primary,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                  _filterGames();
                },
                onTap: () {
                  setState(() {
                    searchQuery = '';
                  });
                  _filterGames();
                },
              ),
            ),
            if (appliedFilters.isNotEmpty)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: appliedFilters.map((filter) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Chip(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                          side: const BorderSide(
                            width: 0,
                          ),
                        ),
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        label: Text(filter,
                            style: const TextStyle(color: Colors.white)),
                        deleteIcon: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                        onDeleted: () {
                          setState(() {
                            appliedFilters.remove(filter);
                          });
                          _filterGames();
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredGames.length,
                itemBuilder: (context, index) {
                  final game = filteredGames[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GameDetailsPage(
                              game: game,
                              hasInternetConnection: false,
                            ),
                          ),
                        ).then((_) => _loadGames());
                      },
                      child: Card(
                        color: Theme.of(context).colorScheme.primary,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.file(
                                File(game.thumbnail),
                                width: double.infinity,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    game.title,
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${game.genre}   ⬤   ${game.platform}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
