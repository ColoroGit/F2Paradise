import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:f2paradise/models/game.dart';
import 'package:f2paradise/pages/p_about.dart';
import 'package:f2paradise/pages/p_game_details.dart';
import 'package:f2paradise/pages/p_my_list.dart';
import 'package:f2paradise/pages/p_search.dart';
import 'package:f2paradise/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseHelper db = DatabaseHelper();
  List<Game> recentGames = [];
  List<Game> recommendedGames = [];
  List<Game> exploreGames = [];
  bool isLoading = true;

  // Modify these variables depending on the result of internet connection
  bool hasInternetConnection = true;
  bool hasLocalData = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await _checkInternetConnection();
    setState(() {
      isLoading = true;
    });
    await Future.delayed(const Duration(milliseconds: 500));
    await _loadRecommendedGames();
    await _loadExploreGames();
    await _loadRecentGames();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    setState(() {
      hasInternetConnection =
          connectivityResult.contains(ConnectivityResult.mobile) ||
              connectivityResult.contains(ConnectivityResult.wifi);
    });
  }

  Future<void> _loadRecommendedGames() async {
    if (hasInternetConnection) {
      String mostFrequentGenre = await db.getMostFrequentGenre();
      if (mostFrequentGenre.isNotEmpty) {
        if (mostFrequentGenre == "Card Game") {
          mostFrequentGenre = "card";
        }
        final response = await http.get(Uri.parse(
            'https://www.freetogame.com/api/games?category=$mostFrequentGenre'));
        if (response.statusCode == 200) {
          final List<dynamic> data = json.decode(response.body);
          List<Game> allRecommendedGames =
              data.map((json) => Game.fromJson(json)).toList();
          List<Game> localGames = await db.getAllGames();
          recommendedGames = allRecommendedGames
              .where((game) =>
                  !localGames.any((localGame) => localGame.id == game.id))
              .toList();
        }
      }
    }
  }

  Future<void> _loadExploreGames() async {
    if (hasInternetConnection) {
      final response =
          await http.get(Uri.parse('https://www.freetogame.com/api/games'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        data.shuffle();
        List<Game> allExploreGames =
            data.map((json) => Game.fromJson(json)).toList();
        List<Game> localGames = await db.getAllGames();
        exploreGames = allExploreGames
            .where((game) =>
                !localGames.any((localGame) => localGame.id == game.id))
            .take(5)
            .toList();
      }
    }
  }

  Future<void> _loadRecentGames() async {
    recentGames = await db.getRecentGames();
    setState(() {
      hasLocalData = recentGames.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home', style: TextStyle(color: Colors.white)),
        backgroundColor: Theme.of(context).colorScheme.surface,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list,
                color: Theme.of(context).colorScheme.secondary),
            onPressed: () {
              Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyListPage()))
                  .then((_) => _loadData());
            },
            tooltip: 'WishList',
          ),
          IconButton(
            icon: Icon(Icons.info_outline,
                color: Theme.of(context).colorScheme.secondary),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AboutPage()));
            },
            tooltip: 'About',
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : (hasInternetConnection)
              ? SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSearchBar(context),
                      if (hasLocalData) _buildSectionTitle('Recent Games'),
                      if (hasLocalData) _buildGameList(recentGames, true),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionTitle('Recommended for You'),
                          _buildGameList(recommendedGames, false),
                          _buildSectionTitle('Explore Something New'),
                          _buildGameList(exploreGames, false),
                        ],
                      )
                    ],
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (hasLocalData) _buildSectionTitle('Recent Games'),
                    if (hasLocalData) _buildGameList(recentGames, true),
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/no_connection.png',
                              width: 150,
                              height: 150,
                            ),
                            const SizedBox(height: 20),
                            const Text('No connection',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center),
                            const SizedBox(height: 10),
                            const Text(
                              'It seems you have no Internet connection\nConnect to a network to see other sections',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: const TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildGameList(List<Game> games, bool fromDB) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: games.length,
        itemBuilder: (context, index) {
          final game = games[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GameDetailsPage(
                    game: game,
                    hasInternetConnection: !fromDB,
                  ),
                ),
              ).then((_) => _loadData());
            },
            child: Card(
              color: Theme.of(context).colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                    ),
                    child: (!fromDB)
                        ? Image.network(
                            game.thumbnail,
                            width: 200,
                            height: 120,
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            File(game.thumbnail),
                            width: 200,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          game.title.length > 20
                              ? '${game.title.substring(0, 17)}...'
                              : game.title,
                          style: TextStyle(
                            color: (fromDB)
                                ? Theme.of(context).colorScheme.secondary
                                : Theme.of(context).colorScheme.tertiary,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${game.genre}   ⬤   ${game.platform}'.length > 23
                              ? '${'${game.genre}   ⬤   ${game.platform}'.substring(0, 20)}...'
                              : '${game.genre}   ⬤   ${game.platform}',
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
          );
        },
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            showCursor: false,
            readOnly: true,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Search',
              hintStyle: TextStyle(
                color: Theme.of(context).colorScheme.tertiary,
              ),
              prefixIcon: Icon(
                Icons.search,
                color: Theme.of(context).colorScheme.tertiary,
              ),
              fillColor: Theme.of(context).colorScheme.primary,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide.none,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchPage(
                    hasInternetConnection: true,
                  ),
                ),
              ).then((_) => _loadData());
            },
          ),
        ),
      ],
    );
  }
}
