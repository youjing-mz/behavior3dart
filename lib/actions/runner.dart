import '../core/basenode.dart';
import '../core/tick.dart';
import '../b3constant.dart';

class Runner extends BaseNode {
  Runner.init(String id, Map<String, dynamic> properties)
      : super(id, properties) {
    name = "Runner";
  }

  @override
  void onEnter(Tick tick) {}

  @override
  void onOpen(Tick tick) {}

  @override
  Status onTick(Tick tick) {
    return Status.RUNNING;
  }

  @override
  void onClose(Tick tick) {}

  @override
  void onExit(Tick tick) {}
}
