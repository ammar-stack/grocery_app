class GroceryModel {
  int? id;
  String groceryname;

  GroceryModel({this.id, required this.groceryname});

  // Convert to Map
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'name': groceryname, // must match column name in the DB
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  // Convert from Map
  factory GroceryModel.fromMap(Map<String, dynamic> map) {
    return GroceryModel(
      id: map['id'],
      groceryname: map['name'], // must match DB column
    );
  }
}
