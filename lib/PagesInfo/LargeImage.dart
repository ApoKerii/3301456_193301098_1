import 'dart:io';
import 'dart:typed_data';

//import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_share/flutter_share.dart';

//import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

//import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:pexels_app/Servis/DosyaMetotlari.dart';
class LargeScreen extends StatefulWidget {
  final String imageurls;

   LargeScreen({Key? key,required this.imageurls}) : super(key: key);

  @override
  _LargeScreenState createState() => _LargeScreenState();
}

///
class _LargeScreenState extends State<LargeScreen> {
  
   Future<void> downloadAssets() async {
   
   
    final ByteData data = await NetworkAssetBundle(Uri.parse(widget.imageurls)).load(widget.imageurls);
    final Uint8List bytes= data.buffer.asUint8List(data.offsetInBytes,data.lengthInBytes);

    final directory = await getTemporaryDirectory();
    final path=directory.path+"/ata1.png";
    await new File(path).writeAsBytes(bytes);
    await ImageGallerySaver.saveFile(path);
    await File(path).delete();



  }


  Future<void> sharefoto() async {
          await FlutterShare.share(
        title: 'Example share',
        text: 'Example share text',
        linkUrl: widget.imageurls,
        chooserTitle: 'Example Chooser Title');
  }

  ////
 Future<void> setWallpaper() async {
 
      String url = widget.imageurls;
      int location = WallpaperManager
          .BOTH_SCREEN;
      var file = await DefaultCacheManager().getSingleFile(url);
      final bool result =
          await WallpaperManager.setWallpaperFromFile(file.path, location);
      print(result);
    
  }


 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 5),
            child: FloatingActionButton(
              heroTag: null,
              onPressed: () => setWallpaper(),
              child:const Icon(Icons.wallpaper),
            ),
          ),
          Container(
            margin:const EdgeInsets.only(bottom: 5),
            child: FloatingActionButton(
              heroTag: null,
              onPressed: () => sharefoto(),
              child:const Icon(Icons.share),
            ),
          ),
          Container(
            margin:const EdgeInsets.only(bottom: 15),
            child: FloatingActionButton(
              heroTag: null,
              onPressed: () async {
                  StorageMethods().dosyaikipdf("favories",widget.imageurls );
              },
              child:const Icon(Icons.favorite),
            ),
          ),

 Container(
            margin:const EdgeInsets.only(bottom: 15),
            child: FloatingActionButton(
              heroTag: null,
              onPressed: () async {
                downloadAssets();
              },
              child:const Icon(Icons.download),
            ),
          ),







        ],
      ),

      ///
      body: Container(
          child: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.blueAccent,
              child: Image.network(
                widget.imageurls,
                fit: BoxFit.cover,
              ),
            ),
          ),
          ///////
          IconButton(
              alignment: Alignment.center,
              icon: Icon(Icons.arrow_back_rounded),
              onPressed: () => Navigator.pop(context))
        ],
      )),
    );
  }
}