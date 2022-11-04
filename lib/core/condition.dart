import 'basenode.dart';
import '../b3constant.dart';

abstract class Condition extends BaseNode {
  Condition(String id, Map<String, String> properties) : super(id, properties) {
    category = CONDITION;
  }
}
