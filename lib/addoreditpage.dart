import 'package:flutter/material.dart';
import 'package:grocery_app/dbhelper.dart';
import 'package:grocery_app/grocerymodel.dart';

class AddorEditpage extends StatefulWidget {
  GroceryModel? model;
  AddorEditpage({this.model,super.key});

  @override
  State<AddorEditpage> createState() => _AddorEditpageState();
}

class _AddorEditpageState extends State<AddorEditpage> {
  TextEditingController nameController = TextEditingController();
  Dbhelper dbb = Dbhelper.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.model != null){
      nameController.text = widget.model!.groceryname;
    }
  }

  saveoredit() async{
    if(widget.model != null){
      await dbb.updateName(GroceryModel(groceryname: nameController.text,id: widget.model!.id));
    }
    else{
      await dbb.insertName(GroceryModel(groceryname: nameController.text));
    }
    Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: widget.model != null ? Text("Edit Note") : Text("Add Note"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Grocery Name')
              ),
            ),
          ),
          SizedBox(height: 75),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 130),
            child: InkWell(
              onTap: (){
                saveoredit();
              },
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.amber
                ),
                child: Center(child: Text(widget.model != null ? 'Edit' : 'Add',style: TextStyle(fontSize: 23),)),
              ),
            ),
          )
        ],
      ),
    );
  }
}