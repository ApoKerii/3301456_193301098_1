



import 'package:flutter/material.dart';
import 'package:pexels_app/Servis/DatabaseHelper.dart';


class DatabaseViewer extends StatefulWidget {
  const DatabaseViewer({super.key});

  @override
  State<DatabaseViewer> createState() => _DatabaseViewerState();
}

class _DatabaseViewerState extends State<DatabaseViewer> {


    Map<int,String>? datas={};
    Future<void> printAllData() async {
    final data = await DatabaseHelper.instance.getAllData();
    data.forEach((row) {
      setState(() {
        datas?.addAll({row["_id"]:row["text"]});
      });
    print('ID: ${row["_id"]}, Text: ${row["text"]}');
    });
    }



     @override
  void initState() {
  
    super.initState();
    printAllData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Previous Search"),),
          body: Container(
            color: Color.fromARGB(255, 230, 232, 215),
            child: Column(
              children: [
                Expanded(
                  child:Container(
                    padding: EdgeInsets.only(left: 5, right: 5, bottom: 5),
                    child: ListView.builder(
                      itemCount: datas?.length,
                      itemBuilder: (context,index){
                      return ListTile(
                        
                        leading: Text(datas!.keys.elementAt(index).toString()),
                        title: Text(datas!.values.elementAt(index)),
                        trailing: IconButton(onPressed: ()async{
                          await DatabaseHelper.instance.deleteData(datas!.keys.elementAt(index));
                        }, icon: Icon(Icons.delete)),
                      );
                    })
                  ) ),
              ],
            ),
          ),
      ),
    );
  }
}

