import 'dart:io';

import 'package:f2paradise/models/game.dart';
import 'package:f2paradise/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class GameDetailsPage extends StatefulWidget {
  const GameDetailsPage(
      {super.key, required this.game, required this.hasInternetConnection});

  final Game game;
  final bool hasInternetConnection;

  @override
  State<StatefulWidget> createState() => _GameDetailsPageState();
}

class _GameDetailsPageState extends State<GameDetailsPage> {
  final DatabaseHelper db = DatabaseHelper();
  bool expanded = false;

  Future<void> _saveGameIfNeeded() async {
    final existingGame = await db.getGameById(widget.game.id);
    if (existingGame == null) {
      if (widget.game.played != 0 || widget.game.like != 0) {
        final directory = await getApplicationDocumentsDirectory();
        final path = '${directory.path}/${widget.game.id}.jpg';
        final response = await http.get(Uri.parse(widget.game.thumbnail));
        final file = File(path);
        await file.writeAsBytes(response.bodyBytes);
        widget.game.thumbnail = path;
        widget.game.timestamp = DateTime.now().millisecondsSinceEpoch;
        await db.insertGame(widget.game);
      }
    } else {
      if (widget.game.played == 0 && widget.game.like == 0) {
        await db.deleteGame(widget.game.id);
      } else {
        widget.game.timestamp = DateTime.now().millisecondsSinceEpoch;
        await db.insertGame(widget.game);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () async {
              await _saveGameIfNeeded();
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(widget.game.title),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    (widget.hasInternetConnection)
                        ? Image.network(
                            widget.game.thumbnail,
                            width: double.infinity,
                            height: 300,
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            File(widget.game.thumbnail),
                            width: double.infinity,
                            height: 300,
                            fit: BoxFit.cover,
                          ),
                    Positioned.fill(
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black54,
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 0,
                      right: 0,
                      child: Column(
                        children: [
                          Text(
                            widget.game.title,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            '${widget.game.genre}   ⬤   ${widget.game.platform}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(150, 40),
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                        ),
                        onPressed: () {
                          launchUrl(Uri.parse(widget.game.gameUrl));
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.games,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Web Site',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(150, 40),
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                        ),
                        onPressed: () async {
                          await Share.share(
                            'Check out this free game I found!! ${widget.game.title}\n\n'
                            'Genre: ${widget.game.genre}\n'
                            'Platform: ${widget.game.platform}\n'
                            'Publisher: ${widget.game.publisher}\n'
                            'Developer: ${widget.game.developer}\n'
                            'Release Date: ${widget.game.releaseDate}\n\n'
                            'And here is its page: ${widget.game.gameUrl}',
                          );
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.share,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Share',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: (widget.game.shortDescription.length > 30)
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              expanded
                                  ? widget.game.shortDescription
                                  : '${widget.game.shortDescription.substring(0, 20)}...',
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.white),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  expanded = !expanded;
                                });
                              },
                              child: Text(
                                expanded ? 'Show less' : 'Show more',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                              ),
                            ),
                          ],
                        )
                      : Text(widget.game.shortDescription,
                          style: const TextStyle(color: Colors.white)),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'About',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Divider(
                        color: Theme.of(context).colorScheme.secondary,
                        thickness: 2,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Publisher',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        widget.game.publisher,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Developer',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        widget.game.developer,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Release Date',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        widget.game.releaseDate,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            child: SafeArea(
              minimum: const EdgeInsets.all(8),
              child: SizedBox(
                height: 160,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      child: IconButton(
                        icon: Icon(
                            (widget.game.like == 1)
                                ? Icons.thumb_up
                                : Icons.thumb_up_alt_outlined,
                            color: Theme.of(context).colorScheme.secondary),
                        onPressed: () {
                          setState(() {
                            if (widget.game.like == 1) {
                              widget.game.like = 0;
                            } else {
                              widget.game.like = 1;
                            }
                          });
                        },
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      child: IconButton(
                        icon: Icon(
                            (widget.game.like == -1)
                                ? Icons.thumb_down
                                : Icons.thumb_down_alt_outlined,
                            color: Theme.of(context).colorScheme.tertiary),
                        onPressed: () {
                          setState(() {
                            if (widget.game.like == -1) {
                              widget.game.like = 0;
                            } else {
                              widget.game.like = -1;
                            }
                          });
                        },
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      child: IconButton(
                        icon: Icon(
                            (widget.game.played != 0)
                                ? Icons.bookmark
                                : Icons.bookmark_add_outlined,
                            color: Colors.white),
                        onPressed: () {
                          showModalBottomSheet(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            isScrollControlled: true,
                            context: context,
                            builder: (context) => DraggableScrollableSheet(
                              expand: false,
                              builder: (context, scrollController) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    ListTile(
                                      leading: Icon(
                                        Icons.check,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                      title: Text(
                                        'Played',
                                        style: TextStyle(
                                            fontWeight:
                                                (widget.game.played == 1)
                                                    ? FontWeight.bold
                                                    : FontWeight.w200,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          widget.game.played = 1;
                                        });
                                        Navigator.pop(context);
                                      },
                                    ),
                                    ListTile(
                                      leading: Icon(
                                        Icons.schedule,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                      title: Text(
                                        'Yet to play',
                                        style: TextStyle(
                                            fontWeight:
                                                (widget.game.played == -1)
                                                    ? FontWeight.bold
                                                    : FontWeight.w200,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          widget.game.played = -1;
                                        });
                                        Navigator.pop(context);
                                      },
                                    ),
                                    if (widget.game.played != 0)
                                      ListTile(
                                        leading: Icon(
                                          Icons.delete,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiary,
                                        ),
                                        title: Text(
                                          'Not in a list',
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .tertiary),
                                        ),
                                        onTap: () {
                                          setState(() {
                                            widget.game.played = 0;
                                          });
                                          Navigator.pop(context);
                                        },
                                      ),
                                  ],
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
