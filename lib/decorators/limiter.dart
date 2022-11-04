import '../core/decorator.dart';
import '../core/tick.dart';
import '../b3constant.dart';

class Limiter extends Decorator {
  int maxLoop = -1;
  Limiter.init(String id, Map<String, dynamic> properties)
      : super(id, properties) {
    name = "Limiter";
    title = "Limit <maxLoop> Activations";
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
    if (i < maxLoop) {
      var status = child!.execute(tick);

      if (status == Status.SUCCESS || status == Status.FAILURE) {
        tick.blackboard.set("i", i + 1, tick.tree.id, id);
      }

      return status;
    }

    return Status.FAILURE;
  }

  @override
  void onClose(Tick tick) {}

  @override
  void onExit(Tick tick) {}
}
