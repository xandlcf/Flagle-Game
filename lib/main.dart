import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flagle Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FlagleGame(),
    );
  }
}

class FlagleGame extends StatefulWidget {
  @override
  _FlagleGameState createState() => _FlagleGameState();
}

class _FlagleGameState extends State<FlagleGame> {
  final List<String> allCountries = [
    'Brazil',
    'USA',
    'Canada',
    'Germany',
    'France',
    'Japan',
    'Australia',
    'India',
    'China',
    'Russia',
    'Italy',
    'Spain',
    'Mexico',
    'Argentina',
    'South Korea',
    'South Africa',
    'Egypt',
    'Sweden',
    'Norway',
    'Denmark',
    'United Kingdom',
    'Netherlands',
    'Belgium',
    'Switzerland',
    'Austria',
    'Poland',
    'Portugal',
    'Greece',
    'Turkey',
    'Ireland',
    'Finland',
    'Hungary',
    'Romania',
    'Serbia',
    'Bulgaria',
    'Croatia',
    'Slovakia',
    'Slovenia',
    'Lithuania',
    'Latvia',
    'Estonia',
    'Belarus',
    'Ukraine',
    'Moldova',
    'Georgia',
    'Armenia',
    'Azerbaijan',
    'Angola',
    'Malawi',
    'Nigeria',
    'Ghana',
    'Kenya',
    'Zimbabwe',
    'Zambia',
    'Botswana',
    'Namibia',
    'Mozambique'
  ];

  final Map<String, String> flags = {
    'Brazil': 'flags/brazil.png',
    'USA': 'flags/usa.png',
    'Canada': 'flags/canada.png',
    'Germany': 'flags/germany.png',
    'France': 'flags/france.png',
    'Japan': 'flags/japan.png',
    'Australia': 'flags/australia.jpg',
    'India': 'flags/india.png',
    'China': 'flags/china.png',
    'Russia': 'flags/russia.png',
    'Italy': 'flags/italy.png',
    'Spain': 'flags/spain.png',
    'Mexico': 'flags/mexico.png',
    'Argentina': 'flags/argentina.jpg',
    'South Korea': 'flags/south-korea.png',
    'South Africa': 'flags/south-africa.png',
    'Egypt': 'flags/egypt.png',
    'Sweden': 'flags/sweden.png',
    'Norway': 'flags/norway.png',
    'Denmark': 'flags/denmark.png',
    'United Kingdom': 'flags/united-kingdom.png',
    'Netherlands': 'flags/netherlands.png',
    'Belgium': 'flags/belgium.jpg',
    'Switzerland': 'flags/switzerland.png',
    'Austria': 'flags/austria.jpg',
    'Poland': 'flags/poland.png',
    'Portugal': 'flags/portugal.png',
    'Greece': 'flags/greece.png',
    'Turkey': 'flags/turkey.png',
    'Ireland': 'flags/ireland.png',
    'Finland': 'flags/finland.png',
    'Hungary': 'flags/hungary.png',
    'Romania': 'flags/romania.png',
    'Serbia': 'flags/serbia.png',
    'Bulgaria': 'flags/bulgaria.png',
    'Croatia': 'flags/croatia.png',
    'Slovakia': 'flags/slovakia.png',
    'Slovenia': 'flags/slovenia.png',
    'Lithuania': 'flags/lithuania.png',
    'Latvia': 'flags/latvia.png',
    'Estonia': 'flags/estonia.png',
    'Belarus': 'flags/belarus.jpg',
    'Ukraine': 'flags/ukraine.png',
    'Moldova': 'flags/moldova.png',
    'Georgia': 'flags/georgia.png',
    'Armenia': 'flags/armenia.jpg',
    'Azerbaijan': 'flags/azerbaijan.jpg',
    'Angola': 'flags/angola.jpg',
    'Malawi': 'flags/malawi.png',
    'Nigeria': 'flags/nigeria.png',
    'Ghana': 'flags/ghana.png',
    'Kenya': 'flags/kenya.png',
    'Zimbabwe': 'flags/zimbabwe.png',
    'Zambia': 'flags/zambia.png',
    'Botswana': 'flags/botswana.jpg',
    'Namibia': 'flags/namibia.png',
    'Mozambique': 'flags/mozambique.png'
  };

  List<String> remainingCountries = [];
  String currentFlag = '';
  String currentCountry = '';
  int attempts = 3;
  int score = 0;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    remainingCountries = List.from(allCountries);
    _pickRandomCountry();
  }

  void _pickRandomCountry() {
    if (remainingCountries.isEmpty) {
      setState(() {
        currentFlag = '';
        currentCountry = '';
      });
      _showCongratulations();
      return;
    }

    final random = Random();
    currentCountry = remainingCountries.removeAt(random.nextInt(remainingCountries.length));
    currentFlag = flags[currentCountry]!;
    attempts = 3;
    setState(() {});
  }

  void _checkAnswer() {
    if (_controller.text.trim().toLowerCase() == currentCountry.toLowerCase()) {
      setState(() {
        score++;
        _pickRandomCountry();
      });
    } else {
      setState(() {
        attempts--;
        if (attempts == 0) {
          score = 0;
          remainingCountries = List.from(allCountries);
          _pickRandomCountry();
        }
      });
    }
    _controller.clear();
  }

  void _showCongratulations() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Congratulations!'),
          content: Text('You won the game!'),
          actions: <Widget>[
            TextButton(
              child: Text('Play Again'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  score = 0;
                  remainingCountries = List.from(allCountries);
                  _pickRandomCountry();
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Can you name all 50 countries?'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Score: $score',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20),
              currentFlag.isEmpty
                  ? Text(
                      'Congratulations! You won the game!',
                      style: TextStyle(fontSize: 24),
                    )
                  : Image.asset(
                      currentFlag,
                      height: 200,
                      width: 300,
                      fit: BoxFit.contain,
                    ),
              SizedBox(height: 20),
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'Enter country name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _checkAnswer,
                child: Text('Submit'),
              ),
              SizedBox(height: 20),
              Text(
                'Attempts left: $attempts',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
