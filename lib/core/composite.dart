import 'basenode.dart';
import '../b3constant.dart';

abstract class Composite extends BaseNode {
  List<BaseNode> children = [];
  Composite(String id, Map<String, dynamic> properties)
      : super(id, properties) {
    category = COMPOSITE;
  }

  void addChild(BaseNode child) {
    children.add(child);
  }

  void removeChild(BaseNode child) {
    children.remove(child);
  }
}
