import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pexels_app/PagesInfo/LargeImage.dart';



class CategoriesPhoto extends StatefulWidget {
  final String photoname;

  CategoriesPhoto({required this.photoname});

  @override
  _CategoriesPhotoState createState() => _CategoriesPhotoState();
}

class _CategoriesPhotoState extends State<CategoriesPhoto> {
  List categoryphoto = [];
  int nextpage = 1;
  categorisedpexelsapi(String query) async {
    await http.get(
        Uri.parse("https://api.pexels.com/v1/search?query=$query&per_page=80"),
        headers: {
          "Authorization":
              "563492ad6f917000010000012009e4b2e6da419094353041d33d4fa2"
        }).then((value) {
      Map photoresult = jsonDecode(value.body);

      setState(() {
        categoryphoto = photoresult["photos"];
      });
    });
  }

  Future<dynamic> trymore(String query) async {
    setState(() {
      nextpage = nextpage + 1;
    });
    String newnextpageurl =
        "https://api.pexels.com/v1/search?query=$query&per_page=80&page=" +
            nextpage.toString();

    await http.get(Uri.parse(newnextpageurl), headers: {
      "Authorization":
          "563492ad6f917000010000012009e4b2e6da419094353041d33d4fa2"
    }).then((value) {
      Map photoresponse = jsonDecode(value.body);

      setState(() {
        categoryphoto.addAll(photoresponse["photos"]);
      });
    });
  }

  @override
  void initState() {
    categorisedpexelsapi(widget.photoname);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "${widget.photoname}",
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                  Colors.red,
                  Colors.deepOrange,
                  Colors.yellowAccent,
                ])),
          ),
        ),
        body: Container(
          //////////////////

          child: Column(
            children: [
////

              Expanded(
                  child: Container(
                padding: EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 5),
                child: GridView.builder(
                    itemCount: categoryphoto.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2 / 3,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        //
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LargeScreen(
                                        imageurls: categoryphoto[index]["src"]
                                            ["original"],
                                      )));
                        },
                        //
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            child: Image.network(
                                categoryphoto[index]["src"]["portrait"],
                                fit: BoxFit.cover),
                          ),
                        ),
                      );
                    }),
              )),



              IconButton(
                icon: Icon(
                  Icons.add,
                  color: Colors.grey[700],
                ),
                onPressed: () => trymore(widget.photoname),
              ),
            ],
          ),
        ),

      ),
    );
  }
}