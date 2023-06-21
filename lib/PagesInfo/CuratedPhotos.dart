

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:pexels_app/PagesInfo/CategoryPage.dart';
import 'package:pexels_app/PagesInfo/DatabaseViewer.dart';
import 'package:pexels_app/PagesInfo/FavPage.dart';
import 'package:pexels_app/PagesInfo/LargeImage.dart';
import 'package:pexels_app/PagesInfo/SearchPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pexels_app/PagesInfo/Textpage.dart';
import 'package:pexels_app/Servis/DatabaseHelper.dart';




class CuratedPhotos extends StatefulWidget {
   UserCredential? credential ;
   CuratedPhotos({super.key ,this.credential});

  @override
  State<CuratedPhotos> createState() => _CuratedPhotosState();
}

class _CuratedPhotosState extends State<CuratedPhotos> with SingleTickerProviderStateMixin {

   
      late AnimationController _controller;
      late Animation<Alignment> _topcontroller;
      late Animation<Alignment> _bottomcontroller;
      

      @override
  void initState() {
   
    super.initState();
    _controller=AnimationController(vsync: this,duration: const Duration(seconds: 6));

    _topcontroller=TweenSequence<Alignment>(

      [
        TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(begin: Alignment.topLeft,end: Alignment.topCenter),
          weight: 1,
           ),
           TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(begin: Alignment.topCenter,end: Alignment.topRight),
          weight: 1,
           ),
           TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(begin: Alignment.topRight,end: Alignment.topCenter),
          weight: 1,
           ),
           TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(begin: Alignment.topCenter,end: Alignment.topLeft),
          weight: 1,
           ),
      ],
    ).animate(_controller);


    _bottomcontroller=TweenSequence<Alignment>(

      [
        TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(begin: Alignment.bottomRight,end: Alignment.bottomCenter),
          weight: 1,
           ),
           TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(begin: Alignment.bottomCenter,end: Alignment.bottomLeft),
          weight: 1,
           ),
           TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(begin: Alignment.bottomLeft,end: Alignment.bottomCenter),
          weight: 1,
           ),
           TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(begin: Alignment.bottomCenter,end: Alignment.bottomRight),
          weight: 1,
           ),
      ],
    ).animate(_controller);

      _controller.repeat();
  }






  @override
  Widget build(BuildContext context) {
     var appBarWidth = AppBar().preferredSize.width;
    var appBarHeight = AppBar().preferredSize.height;
    return  SafeArea(
      child: Scaffold(
        drawer: MyDrawer(credential: widget.credential,),
        appBar:AppBar(
          flexibleSpace: AnimatedBuilder(
            animation: _controller,
             builder: (context,_){
                  return Container(
                    width: appBarWidth,
                    height: appBarHeight,
                    decoration:  BoxDecoration(
                      gradient: LinearGradient(colors: const[
                         Colors.red,
                    
                    
                    Colors.orange,
                    Colors.yellow
                      ],
                      begin: _topcontroller.value,
                      end: _bottomcontroller.value
                      ),
                     
                    ),
                    child: Center(child: Image.asset("assets/images/fire.png"),),
    
                  );
             }),
        ) ,
        body: ViewPhoto(credential: widget.credential,),
      ),
    );
  }
}











class ViewPhoto extends StatefulWidget {
   UserCredential? credential;
   ViewPhoto({super.key,this.credential});

  @override
  State<ViewPhoto> createState() => _ViewPhotoState();
}

class _ViewPhotoState extends State<ViewPhoto> {




  List images = [];
  int page = 1;
  TextEditingController searchcontrol = TextEditingController();


  pexelsapi() async {
    await http.get(Uri.parse("https://api.pexels.com/v1/curated?per_page=42"),
        headers: {
          "Authorization":
              "563492ad6f917000010000012009e4b2e6da419094353041d33d4fa2"
        }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images = result["photos"];
      });
    });
  }


// daha fazla resim yükleme kısmı 


loadmoreimage() async {
    setState(() {
      page = page + 1;
    });
    String newpageurl =
        "https://api.pexels.com/v1/curated?per_page=42&page=" + page.toString();

    await http.get(Uri.parse(newpageurl), headers: {
      "Authorization":
          "563492ad6f917000010000012009e4b2e6da419094353041d33d4fa2"
    }).then((value) {
      Map response = jsonDecode(value.body);

      setState(() {
        images.addAll(response["photos"]);
      });
    });
  }


  Future<void> _saveDataToDatabase() async {
    final text = searchcontrol.text;
    if (text.isNotEmpty) {
      await DatabaseHelper.instance.insert(text);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Veri kaydedildi')),
      );
    }
  }


 @override
  void initState() {
    pexelsapi();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(

        child: Column(
          children: [
            Container(
            width: double.infinity,
            height: 40,
            padding: EdgeInsets.only(right: 15, left: 15),
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.grey[400],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchcontrol,
                    decoration: InputDecoration(
                        hintText: "search", border: InputBorder.none),
                  ),
                ),
                GestureDetector(
                    child: Container(child: Icon(Icons.search)),
                    onTap: () async {
                      
                     _saveDataToDatabase();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchPage(
                                    searchimage: searchcontrol.text,
                                  )));
                    
                    }),
              ],
            ),
          ),






          Expanded(
              child: Container(
            padding: EdgeInsets.only(left: 5, right: 5, bottom: 5),
            child: GridView.builder(
                itemCount: images.length,
                gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 3,
                    crossAxisSpacing: 3,
                    childAspectRatio: 2 / 3),
                itemBuilder: (context, index) {
                  return GestureDetector(
                      child: Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(images[index]["src"]["portrait"],
                              fit: BoxFit.cover),
                        ),
                      ),
                      onDoubleTap: () {
                       
                          Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LargeScreen(imageurls:images[index]["src"]["original"] )));



                      });
                  //
                }),
          )),

      
      
       IconButton(
            splashColor: Colors.white,
            color: Colors.grey[50],
            icon: Icon(
              Icons.add,
              color: Colors.grey[800],
            ),
            onPressed: loadmoreimage,
          ),








          ],
        ),

    );
  }
}







class MyDrawer extends StatefulWidget {
   UserCredential? credential;
   MyDrawer({super.key,this.credential});
  
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {

    FirebaseFirestore firestoreornek=FirebaseFirestore.instance;
    String photourl=""; 
    Future<String> getirici()async{
    String photourls=await firestoreornek.collection("Kullanicilar").doc(widget.credential!.user?.uid).get().then((value){

        setState(() {
          photourl=value["photourl"];
          print(photourl);
        });
        return photourl;
    });
    return photourls;
  }

    Future<void> printAllData() async {
    final data = await DatabaseHelper.instance.getAllData();
    data.forEach((row) {
    print('ID: ${row["_id"]}, Text: ${row["text"]}');
     });
    }


 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getirici();

  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter,end: Alignment.bottomCenter,colors:[ Colors.cyan,
                Colors.deepPurple,
                Colors.grey] )
        ),
        child: ListView(
          children: [
            DrawerHeader(
             
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CircleAvatar(backgroundImage: NetworkImage(photourl),radius: 80,)
                  ],
                ),
              ),
            ),
            ListTile(
              title: Text("Categories"),
              leading: Icon(Icons.image_rounded),
              onTap: () {
                

                    Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => CategoriesPage()));

              },
            ),
            ListTile(
              title: Text("TextFile"),
              leading: Icon(Icons.info_outline),
              onTap: () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => TextViewer()));
              },
            ),
            ListTile(
              
              title: Text("Previous Search"),
              leading: Icon(Icons.backup),
              onTap: () async {
                

                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => DatabaseViewer()));


              },
            ),





             ListTile(
              
              title: Text("Favorites"),
              leading: Icon(Icons.favorite),
              onTap: () async {
                

                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => FavoriPages(credential: widget.credential,)));


              },
            ),
           
          ],
        ),
      ),
    );
  }
}
