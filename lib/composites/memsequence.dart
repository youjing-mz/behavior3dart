import '../core/composite.dart';
import '../core/tick.dart';
import '../b3constant.dart';

class MemSequence extends Composite {
  MemSequence.init(String id, Map<String, dynamic> properties)
      : super(id, properties) {
    name = "MemSequence";
  }
  @override
  void onEnter(Tick tick) {}

  @override
  void onOpen(Tick tick) {
    tick.blackboard.set("runningChild", 0, tick.tree.id, id);
  }

  @override
  Status onTick(Tick tick) {
    var runningChild =
        tick.blackboard.get("runningChild", tick.tree.id, this.id);
    for (var i = runningChild; i < children.length; i++) {
      var status = children[i].execute(tick);

      if (status != Status.SUCCESS) {
        if (status == Status.RUNNING) {
          tick.blackboard.set("runningChild", i, tick.tree.id, id);
        }
        return status;
      }
    }

    return Status.SUCCESS;
  }

  @override
  void onClose(Tick tick) {}

  @override
  void onExit(Tick tick) {}
}
