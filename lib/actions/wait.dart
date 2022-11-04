import '../core/basenode.dart';
import '../core/tick.dart';
import '../b3constant.dart';

class Wait extends BaseNode {
  int endTime = 0;
  Wait.init(String id, Map<String, dynamic> properties)
      : super(id, properties) {
    name = "Wait";
    endTime = properties['milliseconds'] as int;
  }

  @override
  void onEnter(Tick tick) {}

  @override
  void onOpen(Tick tick) {
    tick.blackboard.set("startTime", 0, tick.tree.id, id);
  }

  @override
  Status onTick(Tick tick) {
    int time = tick.blackboard.get("startTime", tick.tree.id, id) as int;
    time += tick.deltaTime;
    if (time > endTime) {
      return Status.SUCCESS;
    }

    tick.blackboard.set("startTime", time, tick.tree.id, id);
    return Status.RUNNING;
  }

  @override
  void onClose(Tick tick) {}

  @override
  void onExit(Tick tick) {}
}
