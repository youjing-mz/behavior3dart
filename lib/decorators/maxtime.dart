import '../core/decorator.dart';
import '../core/tick.dart';
import '../b3constant.dart';

class MaxTime extends Decorator {
  int maxTime = 0;
  MaxTime.init(String id, Map<String, dynamic> properties)
      : super(id, properties) {
    name = "MaxTime";
    title = "Max <maxTime>ms";
    maxTime = int.parse(properties['maxTime']);
  }

  @override
  void onEnter(Tick tick) {}

  @override
  void onOpen(Tick tick) {
    var startTime = tick.getCurTime();
    tick.blackboard.set("startTime", startTime, tick.tree.id, id);
  }

  @override
  Status onTick(Tick tick) {
    if (child == null) {
      return Status.ERROR;
    }

    var curtime = tick.getCurTime();
    var startTime = tick.blackboard.get("startTime", tick.tree.id, id);

    var status = child!.execute(tick);
    if (curtime - startTime > maxTime) {
      return Status.FAILURE;
    }

    return status;
  }

  @override
  void onClose(Tick tick) {}

  @override
  void onExit(Tick tick) {}
}
