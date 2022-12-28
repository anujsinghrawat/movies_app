import 'package:flutter/material.dart';
import 'package:movies_app/services/remote_services.dart';

import '../models/nowplaying.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Movie>? _movies = [];

  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    // populateMovies();
  }

  // void populateMovies() async {
  //   var myMovies = await RemoteService.nowPlaying();
  //   _movies = List.from(myMovies!);
  //   print(_movies![1].title);
  // }

  final List<Widget> _list = [
    Card(
      elevation: 50,
      shadowColor: Colors.black,
      color: Colors.blueAccent,
      child: SizedBox(
        width: 200,
        height: 500,
      ),
    ),
    const SizedBox(
      width: 20,
    ),
    Card(
      elevation: 50,
      shadowColor: Colors.black,
      color: Colors.blueAccent,
      child: SizedBox(
        width: 300,
        height: 500,
      ),
    ),
    const SizedBox(
      width: 20,
    ),
    Card(
      elevation: 50,
      shadowColor: Colors.black,
      color: Colors.blueAccent,
      child: SizedBox(
        width: 300,
        height: 500,
      ),
    ),
    const SizedBox(
      width: 20,
    ),
    Card(
      elevation: 50,
      shadowColor: Colors.black,
      color: Colors.blueAccent,
      child: SizedBox(
        width: 300,
        height: 500,
      ),
    ),
    const SizedBox(
      width: 20,
    ),
    Card(
      elevation: 50,
      shadowColor: Colors.black,
      color: Colors.blueAccent,
      child: SizedBox(
        width: 300,
        height: 500,
      ),
    ),
    const SizedBox(
      width: 20,
    ),
    Card(
      elevation: 50,
      shadowColor: Colors.black,
      color: Colors.blueAccent,
      child: SizedBox(
        width: 200,
        height: 500,
      ),
    ),
    const SizedBox(
      width: 20,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'welcome',
          textAlign: TextAlign.center,
        ),
      ),
      backgroundColor: Color.fromARGB(255, 88, 88, 88),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    //search field
                    child: TextField(
                      onChanged: (String str) {
                        print(str);
                      },
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        iconColor: Colors.black,
                        // suffixIcon: Icon(Icons.search),
                        fillColor: Color.fromARGB(255, 56, 54, 54),
                        border: OutlineInputBorder(),
                        labelText: 'Search for the movie',
                        prefixIcon: Icon(Icons.menu),
                      ),
                    ),
                  ),
                  // Button.icon(onPressed:() => print('hi'),icon: Icon(Icons.search),)
                  ElevatedButton.icon(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.green),
                    ),
                    // onPressed: () => print('hi'),
                    onPressed: () async {
                      List<Movie>? abc = await RemoteService.nowPlaying();
                      print(abc?[0].title);
                    },
                    icon: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    label: Text(''),
                  ),
                ],
              ),

              //trending movies playing
              const SizedBox(height: 50),
              Text(
                'Trending Movies',
                textAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 250,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.all(8),
                    itemCount: _list.length,
                    // itemBuilder: ((contex, index) => _list[index]),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: const EdgeInsets.all(8),
                        height: 50,
                        // color: Color.fromARGB(255, 253, 219, 202),
                        child: Center(child: _list[index]),
                      );
                    }),
              ),

              // upcoming movies
              const SizedBox(height: 50),
              Text(
                'Upcoming Movies',
                textAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 200,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.all(8),
                    itemCount: _list.length,
                    // itemBuilder: ((contex, index) => _list[index]),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: const EdgeInsets.all(8),
                        height: 50,
                        // color: Color.fromARGB(255, 253, 219, 202),
                        child: Center(child: _list[index]),
                      );
                    }),
              ),

              //now playing
              const SizedBox(height: 50),
              Text(
                'Now playing',
                textAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 200,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.all(8),
                    itemCount: _list.length,
                    // itemBuilder: ((contex, index) => _list[index]),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: const EdgeInsets.all(8),
                        height: 50,
                        // color: Color.fromARGB(255, 253, 219, 202),
                        child: Center(child: _list[index]),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
