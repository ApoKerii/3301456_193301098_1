import 'dart:typed_data';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';



class StorageMethods{
  final FirebaseStorage storage=FirebaseStorage.instance;
  final  FirebaseAuth   auth=FirebaseAuth.instance;   
  final FirebaseFirestore cloudfire=FirebaseFirestore.instance;

  Future<String> resimyuklestorage(String childname,Uint8List file,bool isPost)async{
            
     Reference ref= storage.ref().child(childname).child(auth.currentUser!.uid);
     UploadTask uploadtask=ref.putData(file);
     TaskSnapshot snapshot=await uploadtask;
     String downloadurl=await snapshot.ref.getDownloadURL();
       
     return downloadurl;  
  
  }



  Future<String> dosyaikipdf(String childname,String url )async{
     int a=0;
     Random rng = Random();
     var alphabet=["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","r","s","t","u","v","w","x","y",0,1,2,3,4,5,6,7,8,9];
     String name="";
     for(int i=0;i<=10;i++){
      a=rng.nextInt(34);
        name+=alphabet[a].toString();
     }
     print(alphabet.length);
     print("alperen efsanedir"); 

     var file= await NetworkAssetBundle(Uri.parse(url)).load(url);  
     final Uint8List bytes= file.buffer.asUint8List(file.offsetInBytes,file.lengthInBytes);
     Reference ref= storage.ref().child(childname).child(auth.currentUser!.uid).child("photos").child(name);
     UploadTask uploadtask=ref.putData(bytes);
     TaskSnapshot snapshot=await uploadtask;
     String downloadurl=await snapshot.ref.getDownloadURL();
     var aslink;
     var yanlnkler;
     yanlnkler=await cloudfire.collection("Kullanicilar").doc(auth.currentUser!.uid).get().then((value)async{
                    return value["belgeurl"];
     });  
     aslink=yanlnkler;
     aslink.add(downloadurl);
     cloudfire.collection("Kullanicilar").doc(auth.currentUser!.uid).update({"belgeurl":aslink});
     return downloadurl;  
     
     

  }




  





}