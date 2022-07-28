import 'package:flutter/material.dart';
import 'package:lastsearchapp/Pages/imagepage.dart';
import 'package:lastsearchapp/Pages/videopage.dart';
import 'package:lastsearchapp/color_schemes.g.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:styled_widget/styled_widget.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    var mode = [darkColorScheme,lightColorScheme];
    int mo = 0;
    return MaterialApp(
      
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: TextTheme(subtitle1: GoogleFonts.damion()),
        useMaterial3: true,
        colorScheme: mode[mo]
      ),
      home: MyHomePage(),
    );
  }
}
 class MyHomePage extends StatefulWidget {
 const MyHomePage({Key? key,}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
 final Pages = const [ImagePage(),VideoPage()];
 void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        actions: [IconButton(
          onPressed:(){
            _oItemTapped(index){
              _selectedIndex = index;
           
            }
          },
          icon: Icon(Icons.nightlight_round))],
        title: Text('SearchApp',style: GoogleFonts.doHyeon( fontSize: 30),),
      ),
      body: Pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.photo_album,size: 25,),label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.video_camera_back,size: 25,),label: ''),
          
        ]
        ),
    );
  }
}
