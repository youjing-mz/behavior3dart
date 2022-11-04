import '../core/basenode.dart';
import '../core/tick.dart';
import '../b3constant.dart';

class Failer extends BaseNode {
  Failer.init(String id, Map<String, dynamic> properties)
      : super(id, properties) {
    name = "Failer";
  }

  @override
  void onEnter(Tick tick) {}

  @override
  void onOpen(Tick tick) {}

  @override
  Status onTick(Tick tick) {
    return Status.FAILURE;
  }

  @override
  void onClose(Tick tick) {}

  @override
  void onExit(Tick tick) {}
}
