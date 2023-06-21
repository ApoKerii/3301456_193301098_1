import 'package:flutter/material.dart';
import 'package:pexels_app/PagesInfo/Categories.dart';
import 'Category.dart';

class CategoriesPage extends StatefulWidget {
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  List<Categories> urls = [];

  @override
  void initState() {
    urls = getcategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey,
          appBar: AppBar(
            title: Center(
              child: Text("Categories"),
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

          ///
          body: Column(
            children: [
              Expanded(
                child: Container(
                  padding:
                      EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 5),
                  child: GridView.builder(
                      itemCount: urls.length,
                      gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 3,
                          crossAxisSpacing: 3,
                          childAspectRatio: 2 / 3),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          //////
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CategoriesPhoto(
                                        photoname: urls[index].name!)));
                          },
                          /////////
                          child:Expanded(
                                child: Container(
                                 
                                child: ClipRRect(
                                  
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      urls[index].url!,
                                      fit: BoxFit.cover
                                      ,
                                    )),
                                 ),
                              ),
                           







                        );
                      }),
                ),
              ),
              IconButton(
                  alignment: Alignment.center,
                  icon: Icon(Icons.arrow_back_rounded),
                  onPressed: () => Navigator.pop(context))
            ],
          ),
        ),
      ),
    );
  }
}
