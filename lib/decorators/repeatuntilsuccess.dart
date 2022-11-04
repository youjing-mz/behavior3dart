import '../core/decorator.dart';
import '../core/tick.dart';
import '../b3constant.dart';

class RepeatUntilSuccess extends Decorator {
  int maxLoop = -1;
  RepeatUntilSuccess.init(String id, Map<String, dynamic> properties)
      : super(id, properties) {
    name = "RepeatUntilSuccess";
    title = "Repeat Until Success";
    maxLoop = properties['maxLoop'] as int;
  }

  @override
  void onEnter(Tick tick) {}

  @override
  void onOpen(Tick tick) {
    tick.blackboard.set("i", 0, tick.tree.id, id);
  }

  @override
  Status onTick(Tick tick) {
    if (child == null) {
      return Status.ERROR;
    }

    var i = tick.blackboard.get("i", tick.tree.id, id);
    var status = Status.ERROR;

    while (maxLoop < 0 || i < maxLoop) {
      status = child!.execute(tick);

      if (status == Status.FAILURE) {
        i++;
      } else {
        break;
      }
    }

    tick.blackboard.set("i", i, tick.tree.id, id);
    return status;
  }

  @override
  void onClose(Tick tick) {}

  @override
  void onExit(Tick tick) {}
}
