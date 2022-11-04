import '../core/composite.dart';
import '../core/tick.dart';
import '../b3constant.dart';

class Priority extends Composite {
  Priority.init(String id, Map<String, dynamic> properties)
      : super(id, properties) {
    name = "Priority";
  }
  @override
  void onEnter(Tick tick) {}

  @override
  void onOpen(Tick tick) {}

  @override
  Status onTick(Tick tick) {
    for (var i = 0; i < children.length; i++) {
      var status = children[i].execute(tick);

      if (status != Status.FAILURE) {
        return status;
      }
    }

    return Status.FAILURE;
  }

  @override
  void onClose(Tick tick) {}

  @override
  void onExit(Tick tick) {}
}
