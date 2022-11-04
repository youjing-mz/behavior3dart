import '../core/basenode.dart';
import '../core/tick.dart';
import '../b3constant.dart';

class Error extends BaseNode {
  Error.init(String id, Map<String, dynamic> properties)
      : super(id, properties) {
    name = "Error";
  }

  @override
  void onEnter(Tick tick) {}

  @override
  void onOpen(Tick tick) {}

  @override
  Status onTick(Tick tick) {
    return Status.ERROR;
  }

  @override
  void onClose(Tick tick) {}

  @override
  void onExit(Tick tick) {}
}
