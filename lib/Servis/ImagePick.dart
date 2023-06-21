//import 'dart:io' as Io;
//import 'dart:typed_data';
//import 'dart:convert';
import 'package:flutter/services.dart';

import 'package:image_picker/image_picker.dart';
//import 'package:flutter/services.dart' show rootBundle;


resimsecici(ImageSource source)async{
   final ImagePicker imagepicker=ImagePicker();
   XFile? file=await imagepicker.pickImage(source: source);
  

   if(file!=null){
    print("secilen resim kullanıldı");
     return await file.readAsBytes();
   }
   else{
    ByteData byteData = await rootBundle.load("resimler/personimage.jpg");
    Uint8List bytes = byteData.buffer.asUint8List();
    print("varsayılan resim kullanıldı");
    return bytes;

   }
}