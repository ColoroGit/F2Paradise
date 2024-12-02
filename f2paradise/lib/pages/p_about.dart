import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        title: const Text("About"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'F2Paradise',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary),
              ),
              const SizedBox(height: 8),
              const Text(
                'Is a platform dedicated to share free pieces of heaven to our users in the best, centralized and easy way possible, exploring the API provided by freetogames to get all of the free treasures hidden on Earth.\n\nHere you can store the games you like (or don\'t), make your own list of games you would like to try, share them with your friends, and we will be there supporting you with some game recomendations.\n\nYou can use this app offline, but you will only have acces to the games you have saved previously (you\'ll find out this by yourself, but in order for a game to be saved, it must have a like (or a dislike) or be saved in 1 of your lists (played or yet to play)). \n\nAnd remember, the best things in life are free ;)',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 16),
              Text(
                'Developers',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.tertiary),
              ),
              const SizedBox(height: 8),
              const Text(
                'We (Joel & Tomás) are a duet of developers who love games and want to share our passion with the world. We made this platform with love and dedication, and we hope you enjoy it as much as we did while creating it, and of course, you can share this free vault of knwoledge with your friends and family.',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
