import 'package:flutter/material.dart';
import 'package:grocery_app/addoreditpage.dart';
import 'package:grocery_app/dbhelper.dart';
import 'package:grocery_app/grocerymodel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<GroceryModel> listofgrocery = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchgroceries();
  }

  fetchgroceries() async{
    listofgrocery =await Dbhelper.instance.getName();
    setState(() {
      
    });
  }

  deletegroceries(int id) async{
     await Dbhelper.instance.deleteName(id);
     fetchgroceries();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Grocery List"),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: ListView.builder(
        itemCount: listofgrocery.length,
        itemBuilder: (context , index){
          final item = listofgrocery[index];
          return ListTile(
            title: Text(item.groceryname),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(onPressed: () async{
                  await Navigator.push(context, MaterialPageRoute(builder: (context)=> AddorEditpage(model: item)));
                  fetchgroceries();
                }, icon: Icon(Icons.edit),color: Colors.green,),
                IconButton(onPressed: (){
                  deletegroceries(item.id!);
                }, icon: Icon(Icons.delete),color: Colors.red,)
              ],
            ),
          );
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: ()async {
            await Navigator.push(context, MaterialPageRoute(builder: (context) => AddorEditpage()));
            fetchgroceries();
          },
          backgroundColor: Colors.amber,
          child: Icon(Icons.save),
        ),
    );
  }
}