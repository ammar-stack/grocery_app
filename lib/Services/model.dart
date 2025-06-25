class GroceryModel {
  int? id;
  String grocery;

  // Constructor
  GroceryModel({this.id, required this.grocery});

  // Convert a GroceryModel into a Map. Used when inserting into the database.
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'grocery': grocery,
    };

    if (id != null) {
      map['id'] = id;
    }

    return map;
  }

  // Extract a GroceryModel object from a Map. Used when reading from the database.
  factory GroceryModel.fromMap(Map<String, dynamic> map) {
    return GroceryModel(
      id: map['id'],
      grocery: map['grocery'],
    );
  }
}
