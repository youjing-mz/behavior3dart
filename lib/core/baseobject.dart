class BaseObject {
  String id;
  String name = "";
  String category = "";
  String title = "";
  String description = "";
  Map<String, dynamic> properties = {};

  BaseObject(this.id, this.properties);
}
