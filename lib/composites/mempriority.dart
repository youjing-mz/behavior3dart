import '../core/composite.dart';
import '../core/tick.dart';
import '../b3constant.dart';

class MemPriority extends Composite {
  MemPriority.init(String id, Map<String, dynamic> properties)
      : super(id, properties) {
    name = "MemPriority";
  }
  @override
  void onEnter(Tick tick) {}

  @override
  void onOpen(Tick tick) {
    tick.blackboard.set("runningChild", 0, tick.tree.id, id);
  }

  @override
  Status onTick(Tick tick) {
    var runningChild = tick.blackboard.get("runningChild", tick.tree.id, id);
    for (var i = runningChild; i < children.length; i++) {
      var status = children[i].execute(tick);

      if (status != Status.FAILURE) {
        if (status == Status.RUNNING) {
          tick.blackboard.set("runningChild", i, tick.tree.id, id);
        }
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
