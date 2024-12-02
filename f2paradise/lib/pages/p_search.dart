import 'dart:convert';

import 'package:f2paradise/models/game.dart';
import 'package:f2paradise/pages/p_game_details.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, required this.hasInternetConnection});

  final bool hasInternetConnection;

  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Map<String, String> appliedFilters = {};
  Map<String, String> availableFilters = {
    'mmorpg': 'MMORPG',
    'shooter': 'Shooter',
    'strategy': 'Strategy',
    'moba': 'MOBA',
    'racing': 'Racing',
    'sports': 'Sports',
    'social': 'Social',
    'sandbox': 'Sandbox',
    'open-world': 'Open-World',
    'survival': 'Survival',
    'pvp': 'PvP',
    'pve': 'PvE',
    'pixel': 'Pixel',
    'voxel': 'Voxel',
    'zombie': 'Zombie',
    'turn-based': 'Turn-Based',
    'first-person': 'First-Person',
    'third-Person': 'Third-Person',
    'top-down': 'Top-Down',
    'tank': 'Tank',
    'space': 'Space',
    'sailing': 'Sailing',
    'side-scroller': 'Side-Scroller',
    'superhero': 'Superhero',
    'permadeath': 'Permadeath',
    'card': 'Card',
    'battle-royale': 'Battle-Royale',
    'mmo': 'MMO',
    'mmofps': 'MMOFPS',
    'mmotps': 'MMOTPS',
    '3d': '3D',
    '2d': '2D',
    'anime': 'Anime',
    'fantasy': 'Fantasy',
    'sci-fi': 'Sci-Fi',
    'fighting': 'Fighting',
    'action-rpg': 'Action-RPG',
    'action': 'Action',
    'military': 'Military',
    'martial-arts': 'Martial-Arts',
    'flight': 'Flight',
    'low-spec': 'Low-Spec',
    'tower-defense': 'Tower-Defense',
    'horror': 'Horror',
    'mmorts': 'MMORTS'
  };

  String searchQuery = '';
  List<Game> searchResults = [];
  List<Game> allGames = [];
  bool noResults = false;
  bool firstTime = true;

  Future<void> fetchGames() async {
    String url;
    if (appliedFilters.isEmpty) {
      url = 'https://www.freetogame.com/api/games';
    } else {
      url =
          'https://www.freetogame.com/api/filter?tag=${appliedFilters.keys.join(".")}';
    }

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      allGames = data.map((json) => Game.fromJson(json)).toList();
      filterGames();
    } else {
      setState(() {
        noResults = true;
      });
    }
  }

  void filterGames() {
    setState(() {
      if (searchQuery.isEmpty && appliedFilters.isEmpty) {
        noResults = true;
        return;
      }
      searchResults = allGames.where((game) {
        bool matchesSearchQuery = searchQuery.isEmpty ||
            game.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
            game.publisher.toLowerCase().contains(searchQuery.toLowerCase()) ||
            game.developer.toLowerCase().contains(searchQuery.toLowerCase());

        return matchesSearchQuery;
      }).toList();

      noResults = searchResults.isEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        title: const Text("Search"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                autofocus: firstTime,
                cursorColor: Colors.white,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Search',
                  labelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.filter_list,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        context: context,
                        builder: (context) {
                          return ListView(
                            children: availableFilters.entries.map((filter) {
                              return ListTile(
                                title: Text(filter.value,
                                    style:
                                        const TextStyle(color: Colors.white)),
                                onTap: () {
                                  setState(() {
                                    if (!appliedFilters
                                        .containsKey(filter.key)) {
                                      appliedFilters[filter.key] = filter.value;
                                    }
                                  });
                                  Navigator.pop(context);
                                  fetchGames();
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
                    noResults = false;
                    if (firstTime) {
                      firstTime = false;
                    }
                  });
                  fetchGames();
                },
                onTap: () {
                  setState(() {
                    searchQuery = '';
                  });
                },
              ),
            ),
            if (appliedFilters.isNotEmpty)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: appliedFilters.entries.map((entry) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Chip(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                          side: const BorderSide(
                            width: 0,
                          ),
                        ),
                        backgroundColor: Theme.of(context).colorScheme.tertiary,
                        label: Text(entry.value,
                            style: const TextStyle(color: Colors.white)),
                        deleteIcon: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                        onDeleted: () {
                          setState(() {
                            appliedFilters.remove(entry.key);
                            noResults = false;
                          });
                          fetchGames();
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
            Expanded(
              child: searchResults.isEmpty || noResults
                  ? const Center(
                      child: Text(
                        'No games found',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : ListView.builder(
                      itemCount: searchResults.length,
                      itemBuilder: (context, index) {
                        final game = searchResults[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GameDetailsPage(
                                    game: game,
                                    hasInternetConnection:
                                        widget.hasInternetConnection,
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              color: Theme.of(context).colorScheme.primary,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      game.thumbnail,
                                      width: double.infinity,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          game.title,
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .tertiary,
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
