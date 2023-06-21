//import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pexels_app/PagesInfo/CuratedPhotos.dart';
import 'Servis/KayitMetotlari.dart';

import "PagesInfo/RegisterPage.dart";

void main()async {
 WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
/*
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
        if(snapshot.hasData){
            return AppbarBuild();
        }
        else{
          return LoginPage();
        }
      }),
    );
  }
}*/


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

          debugShowCheckedModeBanner: false,
          home: GirisSayfasi(),
    );
  }
}



class GirisSayfasi extends StatefulWidget {
  const GirisSayfasi({Key? key}) : super(key: key);

  @override
  State<GirisSayfasi> createState() => _GirisSayfasiState();
}

class _GirisSayfasiState extends State<GirisSayfasi> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 15, right: 15),
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Colors.red,
                   Colors.orange,
                   Colors.yellow
                  ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
          child: Column(
            children: [
             const SizedBox(
                height: 100,
              ),
              Container(
                width: 120,
                height: 120,
                
                child: Image.asset("assets/images/fire.png"),
              ),
             const SizedBox(
                height: 80,
              ),
              TextField(
                controller: email,
                decoration:const InputDecoration(
                    prefixIcon: Icon(Icons.mail), hintText: "email"),
              ),
             const SizedBox(
                height: 80,
              ),
              TextField(
                controller: password,
                decoration:const InputDecoration(
                    prefixIcon: Icon(Icons.password), hintText: "şifre"),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                width: double.infinity,
                padding:const EdgeInsets.only(left: 20,right: 20),
                child: ElevatedButton(
                    onPressed: () async {
                      if (email.text.isEmpty || password.text.isEmpty) {
                        showDialog(
                            context: context,
                            builder: (
                              context,
                            ) {
                              return const AlertDialog(
                                content: Text(
                                    "Lütfen email ve şifre alanlarını doldurunuz"),
                              );
                            });
                      } else {
                        KayitIslemleri()
                            .girisyap(email.text, password.text)
                            .then((value) async {
                               Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CuratedPhotos(
                                          credential: value,
                                        )),
                                (route) => false);
                            return value.user!.uid;     
                       
                        });
                      }
                    },
                    child: Text("Giriş")),
              ),
             const SizedBox(
                height: 40,
              ),
              TextButton(onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder:(context)=>const KayitSayfasi()));
              }, child:const Text("Kaydol"))
            ],
          ),
        ),
      ),
    );
  }
}











