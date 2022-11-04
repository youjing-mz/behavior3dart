import 'basenode.dart';
import '../b3constant.dart';

abstract class Action extends BaseNode {
  Action(String id, Map<String, String> properties) : super(id, properties) {
    category = ACTION;
  }
}
