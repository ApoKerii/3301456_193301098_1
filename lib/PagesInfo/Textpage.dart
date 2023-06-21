

import 'dart:io';
import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart';




class TextViewer extends StatefulWidget {
  const TextViewer({super.key});

  @override
  State<TextViewer> createState() => _TextViewerState();
}

class _TextViewerState extends State<TextViewer> {

 
  TextEditingController textver=TextEditingController();
  String veriyaz="";

  Future<String> getFilePath() async {
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory(); 
    String appDocumentsPath = appDocumentsDirectory.path; 
    String filePath = '$appDocumentsPath/demoTextFile.txt'; 

    return filePath;
  }

    void saveFile(String data) async {
    File file = File(await getFilePath()); 
    file.writeAsString("${data}"); 
    }
    void readFile() async {
    File file = File(await getFilePath());
    String fileContent = await file.readAsString(); 

   setState(() {
        veriyaz=fileContent;
   });
  }

  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
    double h=MediaQuery.of(context).size.height;
    return SafeArea(child: Scaffold(
      appBar: AppBar(title:const Text("TextFile"),),
      body: Container(
        padding: EdgeInsets.only(right: 20,left: 20),
        width: w,
        height: h,
        child: Center(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
          children: [

              TextField(controller: textver,),
             // Text("${textfromfile}"),

              //TextButton(onPressed: ()=>getdata(), child:Text("Get text")),
             // TextButton(onPressed: ()=>cleartext(), child: Text("Clear text"))
              SizedBox(height: 40,),
              TextButton(onPressed: ()=>saveFile(textver.text), child: Text("Save")),
               SizedBox(height: 10,),
                TextButton(onPressed: ()=>readFile(), child: Text("Read")),
                SizedBox(height: 40,),
              Text("$veriyaz")
          ],
        )),
      ),

    ));
  }
}

