import 'package:flutter/material.dart';
import 'package:lastsearchapp/Pages/imagepage.dart';
import 'package:lastsearchapp/Pages/videopage.dart';
import 'package:lastsearchapp/color_schemes.g.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lastsearchapp/counter_app/counter_app.dart';
import 'package:styled_widget/styled_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    var mode = [darkColorScheme, lightColorScheme];
    int dark = 0;
    int bright = 1;
    change(index) {
      setState(() {
        dark != bright;
      });
    }

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          textTheme: TextTheme(subtitle1: GoogleFonts.singleDay(fontSize: 20)),
          useMaterial3: true,
          colorScheme: mode[0]),
      home: CounterApp(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.change}) : super(key: key);
  final change;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final Pages = const [ImagePage(), VideoPage()];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    adasd() {}
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                _oItemTapped(index) {
                  setState(() {});
                }
              },
              icon: Icon(Icons.nightlight_round))
        ],
        title: Text(
          'SearchApp',
          style: GoogleFonts.doHyeon(fontSize: 30),
        ),
      ),
      body: Pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: _onItemTapped,
          currentIndex: _selectedIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.photo_album,
                  size: 25,
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.video_camera_back,
                  size: 25,
                ),
                label: ''),
          ]),
    );
  }
}
