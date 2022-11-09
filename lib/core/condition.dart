import 'basenode.dart';
import '../b3constant.dart';

abstract class Condition extends BaseNode {
  Condition(String id, Map<String, dynamic> properties)
      : super(id, properties) {
    category = CONDITION;
  }
}
