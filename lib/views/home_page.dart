import 'package:flutter/material.dart';
import 'package:movie_db/services/remote_service.dart';

import '../models/post.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MovieModel? posts;
  var isLoaded = false;

  @override
  void initState(){
    super.initState();


getData();

  }


  getData() async{
    posts = await RemoteService().getPosts();
    if (posts != null){
      setState(() {
        isLoaded = true;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Posts'),
        ),
        body: Visibility(
          visible: isLoaded,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: ListView.builder(
              itemCount: posts?.results?.length,
              itemBuilder: (context, index) {
                return Container(
                  child: Text(posts!.results![index].title!),
                );
              }),
        ));
  }
}
