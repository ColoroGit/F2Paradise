import 'package:f2paradise/pages/p_about.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Modify these variables depending on the result of internet connection
  bool hasInternetConnection = true;
  bool hasLocalData = true;

  @override
  Widget build(BuildContext context) {
    if (hasInternetConnection) {
      return buildOnlineContent();
    } else if (!hasInternetConnection && hasLocalData) {
      return buildOfflineWithLocalDataContent();
    } else {
      return buildNoInternetContent();
    }
  }

  Widget buildOnlineContent() {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(color: Colors.white)
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.favorite_border,
              color: Theme.of(context).colorScheme.secondary
            ),
            onPressed: () {
              // Add code here to navigate to Wishlist page.
            },
            tooltip: 'WishList',
          ),
          IconButton(
            icon: Icon(
              Icons.info_outline,
              color: Theme.of(context).colorScheme.secondary
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutPage()),
              );
            },
            tooltip: 'About',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Search bar.
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search_outlined,
                          color: Theme.of(context).colorScheme.tertiary
                        ),
                        hintText: 'Search by title, genre, etc.',
                        filled: true,
                        fillColor: Color(0xFF232323),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide.none
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.filter_alt_outlined,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                          onPressed: () {
                            // Add code here to display pop-up with tags to select.
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Tags for categories.
              Text(
                'Categories',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 10),
              Container(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    CategoryTag(label: 'Action'),
                    CategoryTag(label: 'Adventure'),
                    CategoryTag(label: 'Strategy'),
                    CategoryTag(label: 'RPG'),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // Recents section.
              Text(
                'Recents',
                style: TextStyle(color: Colors.white)
              ),
              SizedBox(height: 10),
              Container(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    GameCard('gameName1', 'content1', 'assets/icons/i_bird.jpg'),
                    GameCard('gameName2', 'content2', 'assets/icons/i_bird.jpg'),
                    GameCard('gameName3', 'content3', 'assets/icons/i_bird.jpg'),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // Recommended section.
              Text(
                'Recommended',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 10),
              Container(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    GameCard('gameName4', 'content4', 'assets/icons/i_bird.jpg'),
                    GameCard('gameName5', 'content5', 'assets/icons/i_bird.jpg'),
                    GameCard('gameName6', 'content6', 'assets/icons/i_bird.jpg'),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // Explore-something-new section.
              Text(
                'Explore something new',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 10),
              Container(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    GameCard('gameName7', 'content7', 'assets/icons/i_bird.jpg'),
                    GameCard('gameName8', 'content8', 'assets/icons/i_bird.jpg'),
                    GameCard('gameName9', 'content9', 'assets/icons/i_bird.jpg'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildOfflineWithLocalDataContent() {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(color: Colors.white)
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.favorite_border,
              color: Theme.of(context).colorScheme.secondary
            ),
            onPressed: () {
              // Add code here to navigate to Wishlist page.
            },
            tooltip: 'WishList',
          ),
          IconButton(
            icon: Icon(
              Icons.info_outline,
              color: Theme.of(context).colorScheme.secondary
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutPage()),
              );
            },
            tooltip: 'About',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Search bar.
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search_outlined,
                          color: Theme.of(context).colorScheme.tertiary
                        ),
                        hintText: 'Search by title, genre, etc.',
                        filled: true,
                        fillColor: Color(0xFF232323),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide.none
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.filter_alt_outlined,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                          onPressed: () {
                            // Add code here to display pop-up with tags to select.
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Tags for categories.
              Text(
                'Categories',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 10),
              Container(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    CategoryTag(label: 'Action'),
                    CategoryTag(label: 'Adventure'),
                    CategoryTag(label: 'Strategy'),
                    CategoryTag(label: 'RPG'),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // Recents section.
              Text(
                'Recents',
                style: TextStyle(color: Colors.white)
              ),
              SizedBox(height: 10),
              Container(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    GameCard('gameName1', 'content1', 'assets/icons/i_bird.jpg'),
                    GameCard('gameName2', 'content2', 'assets/icons/i_bird.jpg'),
                    GameCard('gameName3', 'content3', 'assets/icons/i_bird.jpg'),
                  ],
                ),
              ),
              SizedBox(height: 50),
              // No internet image.
              Center(
                child: Image.asset(
                  'assets/icons/i_bird.jpg',
                  width: 150,
                  height: 150,
                ),
              ),
              SizedBox(height: 20),
              // No internet message.
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'No connection',
                      style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'It seems you have no Internet connection\nConnect to a network to see other sections',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNoInternetContent() {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.favorite_border,
              color: Theme.of(context).colorScheme.secondary,
            ),
            onPressed: () {
              // Add code here to navigate to Wishlist page.
            },
            tooltip: 'WishList',
          ),
          IconButton(
            icon: Icon(
              Icons.info_outline,
              color: Theme.of(context).colorScheme.secondary,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutPage()),
              );
            },
            tooltip: 'About',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 50),
              // No internet image.
              Center(
                child: Image.asset(
                  'assets/icons/i_bird.jpg',
                  width: 150,
                  height: 150,
                ),
              ),
              SizedBox(height: 20),
              // No internet message.
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'No connection',
                      style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'It seems you have no Internet connection\nConnect to a network and try again',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryTag extends StatefulWidget {
  final String label;
  final bool isSelected;

  CategoryTag({required this.label, this.isSelected = false});

  @override
  _CategoryTagState createState() => _CategoryTagState();
}

class _CategoryTagState extends State<CategoryTag> {
  late bool _isSelected;

  @override
  void initState() {
    super.initState();
    _isSelected = widget.isSelected;
  }

  void _behavior() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: GestureDetector(
        onTap: _behavior,
        child: Chip(
          label: Text(widget.label),
          backgroundColor: _isSelected ? Theme.of(context).colorScheme.secondary : Color(0xFF232323),
          labelStyle: const TextStyle(color: Colors.white),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
    );
  }
}

class GameCard extends StatelessWidget {
  final String headline;
  final String content;
  final String imagePath;

  GameCard(this.headline, this.content, this.imagePath);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFF232323),
      child: Container(
        width: 250,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Image.asset(imagePath, fit: BoxFit.contain, width: 250, height: 125),
                Positioned(
                  top: 8.0,
                  right: 8.0,
                  child: IconButton(
                    icon: Icon(
                      Icons.favorite_border,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    onPressed: () {
                      // Add code here to add the game to wishlist.
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                headline,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                content,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
