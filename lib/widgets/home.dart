import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movies_app/services/remote_services.dart';
import 'package:movies_app/widgets/login_page.dart';

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
  void initState() {
    // response =await RemoteService.nowPlaying();
    super.initState();
    populateMovies();
  }

  void populateMovies() async {
    abc = await RemoteService.nowPlaying();
    bcd = await RemoteService.trending();
    cde = await RemoteService.topRated();

    if (abc != null) {
      setState(() {
        isLoaded = true;
      });
    }
    if (cde != null) {
      setState(() {
        isLoaded1 = true;
      });
    }
    if (bcd != null) {
      setState(() {
        isLoaded2 = true;
      });
    }
  }

  // final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
  //   final user = userCredential.user;
  // print(user?.uid);

  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Welcome ${FirebaseAuth.instance.currentUser!.displayName} ',
          style: const TextStyle(
            fontSize: 22,
            color: Colors.amber,
          ),
          textAlign: TextAlign.center,
        ),
        actions: [
          IconButton(
            onPressed: () {
              auth.signOut().then((value) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginWidget()));
              }).onError((error, stackTrace) {
                print(error.toString());
              });
            },
            icon: const Icon(Icons.logout_rounded),
          ),
          const SizedBox(
            width: 20,
          )
        ],
        automaticallyImplyLeading: false,
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
                  const SizedBox(
                    height: 50,
                  ),
                  Expanded(
                    //search field
                    child: SizedBox(
                      height: 50,
                      child: TextField(
                        decoration: InputDecoration(
                            prefixIcon: const Align(
                                widthFactor: 1.0,
                                heightFactor: 1.0,
                                child:
                                    FaIcon(FontAwesomeIcons.magnifyingGlass)),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade400),
                            ),
                            fillColor: const Color.fromARGB(255, 53, 53, 53),
                            filled: true,
                            hintText: 'Search for movies',
                            hintStyle: TextStyle(color: Colors.grey[500])),
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        // side: const BorderSide(color: Colors.red)
                      ),
                      backgroundColor: Colors.amber,
                      foregroundColor: const Color.fromARGB(255, 83, 83, 83),
                      minimumSize: const Size(45, 50),
                      textStyle: const TextStyle(fontSize: 22),
                    ),
                    onPressed: () async {},
                    icon: const Icon(
                      Icons.search,
                    ),
                    label: const Text(''),
                  ),
                ],
              ),

              //Now playing
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text(
                    'Now playing',
                    style: TextStyle(
                        color: Colors.amberAccent,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 400,
                child: Visibility(
                  visible: isLoaded,
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.all(8),
                      itemCount: abc?.length,
                      // itemBuilder: ((contex, index) => _list[index]),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          
                          color: Color.fromARGB(255, 145, 109, 0),
                          padding: const EdgeInsets.all(8),
                          height: 350,
                          width: 300,
                          child: Column(
                            children: [
                              FadeInImage.assetNetwork(
                                // Before image load
                                placeholder:
                                    'assets/placeholder.png', // Before image load
                                image: baseUrl +
                                    abc![index]
                                        .poster_path
                                        .toString(), // After image load
                                height: 300,
                                width: 250,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(abc![index].title.toString()),
                              const SizedBox(
                                height: 8,
                              ),
                              Text('Rating...${abc![index].stars?.toDouble()}'),
                              
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
                  replacement: const CircularProgressIndicator(),
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
                              FadeInImage.assetNetwork(
                                // Before image load
                                placeholder:
                                    'assets/placeholder.png', // Before image load
                                image: baseUrl +
                                    bcd![index]
                                        .poster_path
                                        .toString(), // After image load
                                height: 300,
                                width: 250,
                              ),
                              Text(bcd![index].title.toString()),
                              Text('Rating...${abc![index].stars?.toDouble()}')
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
                              FadeInImage.assetNetwork(
                                // Before image load
                                placeholder:
                                    'assets/placeholder.png', // Before image load
                                image: baseUrl +
                                    cde![index]
                                        .poster_path
                                        .toString(), // After image load
                                height: 300,
                                width: 250,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(cde![index].title.toString()),
                              const SizedBox(
                                height: 8,
                              ),
                              Text('Rating...${abc![index].stars?.toDouble()}')
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
