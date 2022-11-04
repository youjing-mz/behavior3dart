import 'basenode.dart';
import '../b3constant.dart';

abstract class Decorator extends BaseNode {
  BaseNode? child;
  Decorator(String id, Map<String, dynamic> properties)
      : super(id, properties) {
    category = DECORATOR;
  }

  void setChild(BaseNode child) {
    this.child = child;
  }
}
