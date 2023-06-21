





import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FavoriPages extends StatefulWidget {
   UserCredential? credential;
   FavoriPages({super.key ,this.credential});

  @override
  State<FavoriPages> createState() => _FavoriPagesState();
}

class _FavoriPagesState extends State<FavoriPages> {



FirebaseFirestore firestoreornek = FirebaseFirestore.instance;


    List<dynamic> urldatas=[];

    Future<List<dynamic>> favgetirici()async{
    List<dynamic> photourls=await firestoreornek.collection("Kullanicilar").doc(widget.credential!.user?.uid).get().then((value){

        setState(() {
          urldatas=value["belgeurl"];
         
        });
        return urldatas ;
    });
    return photourls;
  }


    @override
  void initState() {
  
    super.initState();
    favgetirici();
  }

   



  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(title: Text("Favories"),),
      body: Container(
        child: Column(
          children: [
        Expanded(child:Container(
           padding:const EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 5),
           child: GridView.builder(
                              itemCount: urldatas.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2 / 3,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5), itemBuilder: (context,index){
                          return GestureDetector(
                            child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            child: Image.network(
                                urldatas[index]     ,
                                fit: BoxFit.cover),
                          ),
                        ),
                          );
                        }
                        
                        
                        ),
        ))
          ],
        ),
      ),
    ));
  }
}