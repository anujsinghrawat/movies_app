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
                // print(error.toString());
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
                      width: 100,
                      child: TextField(
                        decoration: InputDecoration(
                            prefixIcon: const Align(
                                widthFactor: 1.0,
                                heightFactor: 1.0,
                                child: FaIcon(FontAwesomeIcons.bars)),
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
              const SizedBox(height: 10),
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
                height: 5,
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
                      // padding: const EdgeInsets.all(8),
                      itemCount: abc?.length,
                      // itemBuilder: ((contex, index) => _list[index]),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          padding: const EdgeInsets.all(10),
                          height: 375,
                          width: 275,
                          child: Column(
                            children: [
                              Card(
                                shadowColor: Colors.blue,
                                color: const Color.fromARGB(255, 16, 33, 41),
                                elevation: 3.0,
                                shape: const RoundedRectangleBorder(
                                  side: BorderSide(
                                    // color:
                                    //     Theme.of(context).colorScheme.outline,
                                  ),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(12)),
                                ),
                                child: FadeInImage.assetNetwork(
                                  // Before image load
                                  placeholder:
                                      'assets/placeholder.png', // Before image load
                                  image: baseUrl +
                                      abc![index]
                                          .poster_path
                                          .toString(), // After image load
                                  height: 275,
                                  width: 225,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.blueAccent,
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      abc![index].title.toString(),
                                      style: const TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                        'Rating  - ${abc![index].stars?.toDouble()} ⭐'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                ),
              ),




              //Trending  
              // const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text(
                    'Trending Movies',
                    style: TextStyle(
                        color: Colors.amberAccent,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
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
                      // padding: const EdgeInsets.all(8),
                      itemCount: bcd?.length,
                      // itemBuilder: ((contex, index) => _list[index]),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          padding: const EdgeInsets.all(10),
                          height: 375,
                          width: 275,
                          child: Column(
                            children: [
                              Card(
                                shadowColor: Colors.blue,
                                color: const Color.fromARGB(255, 16, 33, 41),
                                elevation: 3.0,
                                shape: const RoundedRectangleBorder(
                                  side: BorderSide(
                                    // color:
                                    //     Theme.of(context).colorScheme.outline,
                                  ),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(12)),
                                ),
                                child: FadeInImage.assetNetwork(
                                  // Before image load
                                  placeholder:
                                      'assets/placeholder.png', // Before image load
                                  image: baseUrl +
                                      bcd![index]
                                          .poster_path
                                          .toString(), // After image load
                                  height: 275,
                                  width: 225,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.blueAccent,
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      bcd![index].title.toString(),
                                      style: const TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                        'Rating  - ${bcd![index].stars?.toDouble()} ⭐'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                ),
              ),





              //TopRated
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text(
                    'Top Rated Movies',
                    style: TextStyle(
                        color: Colors.amberAccent,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
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
                      // padding: const EdgeInsets.all(8),
                      itemCount: cde?.length,
                      // itemBuilder: ((contex, index) => _list[index]),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          padding: const EdgeInsets.all(10),
                          height: 375,
                          width: 275,
                          child: Column(
                            children: [
                              Card(
                                shadowColor: Colors.blue,
                                color: const Color.fromARGB(255, 16, 33, 41),
                                elevation: 3.0,
                                shape: const RoundedRectangleBorder(
                                  side: BorderSide(
                                    // color:
                                    //     Theme.of(context).colorScheme.outline,
                                  ),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(12)),
                                ),
                                child: FadeInImage.assetNetwork(
                                  // Before image load
                                  placeholder:
                                      'assets/placeholder.png', // Before image load
                                  image: baseUrl +
                                      cde![index]
                                          .poster_path
                                          .toString(), // After image load
                                  height: 275,
                                  width: 225,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.blueAccent,
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      cde![index].title.toString(),
                                      style: const TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                        'Rating  - ${cde![index].stars?.toDouble()} ⭐'),
                                  ],
                                ),
                              ),
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
