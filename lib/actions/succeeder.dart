import '../core/basenode.dart';
import '../core/tick.dart';
import '../b3constant.dart';

class Succeeder extends BaseNode {
  Succeeder.init(String id, Map<String, dynamic> properties)
      : super(id, properties) {
    name = "Succeeder";
  }

  @override
  void onEnter(Tick tick) {}

  @override
  void onOpen(Tick tick) {}

  @override
  Status onTick(Tick tick) {
    return Status.SUCCESS;
  }

  @override
  void onClose(Tick tick) {}

  @override
  void onExit(Tick tick) {}
}
