import 'package:flutter/material.dart';
import 'package:grocery_app/Services/dbhelper.dart';
import 'package:grocery_app/Services/model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController groceryController = TextEditingController();
  List<GroceryModel> groceriesList = [];
  GroceryModel? selectedItem; // For update tracking

  @override
  void initState() {
    super.initState();
    refreshList();
  }

  void refreshList() async {
    groceriesList = await Dbhelper.instance.getData();
    setState(() {});
  }

  void insertOrUpdate() async {
    String input = groceryController.text.trim();
    if (input.isEmpty) return;

    if (selectedItem != null) {
      // Update
      GroceryModel updated = GroceryModel(
        id: selectedItem!.id,
        grocery: input,
      );
      await Dbhelper.instance.updateData(updated);
    } else {
      // Insert
      GroceryModel newItem = GroceryModel(grocery: input);
      await Dbhelper.instance.insertData(newItem);
    }

    groceryController.clear();
    selectedItem = null;
    refreshList();
  }

  void deleteItem(GroceryModel item) async {
    await Dbhelper.instance.deleteData(item);
    refreshList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: groceryController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter Grocery Name',
            suffixIcon: IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                groceryController.clear();
                selectedItem = null;
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: insertOrUpdate,
        child: Icon(Icons.save),
      ),
      body: ListView.builder(
        itemCount: groceriesList.length,
        itemBuilder: (context, index) {
          final data = groceriesList[index];
          return ListTile(
            title: Text(data.grocery),
            leading: IconButton(
              icon: Icon(Icons.edit),
              color: Colors.green,
              onPressed: () {
                setState(() {
                  groceryController.text = data.grocery;
                  selectedItem = data;
                });
              },
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              color: Colors.red,
              onPressed: () => deleteItem(data),
            ),
          );
        },
      ),
    );
  }
}
