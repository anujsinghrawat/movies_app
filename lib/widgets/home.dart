import 'package:flutter/material.dart';
import 'package:movies_app/services/remote_services.dart';

import '../models/nowplaying.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  List<Movie>? abc = [];
  List<Movie>? bcd = [];
  List<Movie>? cde = []; 

  var isLoaded = false;
  var isLoaded1 = false;
  var isLoaded2 = false;

  var baseUrl = 'http://image.tmdb.org/t/p/w500';

  @override
  void initState(){
    // response =await RemoteService.nowPlaying();
    super.initState();
    populateMovies();
  }



  void populateMovies() async {
    abc = await RemoteService.nowPlaying();
    bcd = await RemoteService.trending();
    cde = await RemoteService.topRated();

    if(abc != null){
      setState(() {
        isLoaded = true;
      });
    }
    if(cde != null){
      setState(() {
        isLoaded1 = true;
      });
    }
    if(bcd != null){
      setState(() {
        isLoaded2 = true;
      });
    }
  }

  final List<Widget> _list = [
    const SizedBox(
      width: 20,
    ),
    const Card(
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
    const Card(
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
    const Card(
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
    const Card(
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
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'welcome',
          textAlign: TextAlign.center,
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 88, 88, 88),
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
                      decoration: const InputDecoration(
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
                  ElevatedButton.icon(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.green),
                    ),
                    // onPressed: () => print('hi'),
                    onPressed: () async {
                      // List<Movie>? abc = await RemoteService.nowPlaying();
                      // print(abc?[0].title);
                      // List<Movie>? bcd = await RemoteService.trending();
                      // print(bcd?[0].title);
                      // List<Movie>? cde = await RemoteService.topRated();
                      // print(cde?[0].title);
                    },
                    icon: const Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    label: const Text(''),
                  ),
                ],
              ),

              //trending movies playing
              const SizedBox(height: 50),
              const Text(
                'Now playing',
                textAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 400,
                child: Visibility(
                  visible: isLoaded,
                  replacement: const Center(child: CircularProgressIndicator(),),
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.all(8),
                      itemCount: abc?.length,
                      // itemBuilder: ((contex, index) => _list[index]),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          padding: const EdgeInsets.all(8),
                          height: 350,
                          width: 300,
                          child: Column(
                            children: [
                              FadeInImage.assetNetwork(// Before image load
                                placeholder: 'assets/placeholder.png', // Before image load
                                image: baseUrl+abc![index].poster_path.toString(), // After image load
                                height: 300,
                                width: 250,
                              ),
                              Text(abc![index].title.toString()),
                            ],
                          ),
                        );
                      }),

                ),
              ),

              // upcoming movies
              const SizedBox(height: 50),
              const Text(
                'Trending',
                textAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 400,
                child: Visibility(
                  visible: isLoaded1,
                  replacement: CircularProgressIndicator(),
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.all(8),
                      itemCount: bcd?.length,
                      // itemBuilder: ((contex, index) => _list[index]),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                
                            padding: const EdgeInsets.all(8),
                            height: 350,
                            width: 300,
                            child: Column(
                              children: [
                                FadeInImage.assetNetwork(// Before image load
                                  placeholder: 'assets/placeholder.png', // Before image load
                                  image: baseUrl+bcd![index].poster_path.toString(), // After image load
                                  height: 300,
                                  width: 250,
                                ),
                                Text(bcd![index].title.toString()),
                              ],
                            ),
                          );
                      }),
                ),
              ),

              //now playing
              const SizedBox(height: 50),
              const Text(
                'Top Rated',
                textAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 400,
                child: Visibility(
                  visible: isLoaded2,
                  replacement: const CircularProgressIndicator(),
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.all(8),
                      itemCount: cde?.length,
                      // itemBuilder: ((contex, index) => _list[index]),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                
                            padding: const EdgeInsets.all(8),
                            height: 350,
                            width: 300,
                            child: Column(
                              children: [
                                FadeInImage.assetNetwork(// Before image load
                                  placeholder: 'assets/placeholder.png', // Before image load
                                  image: baseUrl+cde![index].poster_path.toString(), // After image load
                                  height: 300,
                                  width: 250,
                                ),
                                Text(cde![index].title.toString()),
                              ],
                            ),
                          );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
