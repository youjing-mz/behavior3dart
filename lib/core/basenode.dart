import 'tick.dart';
import 'baseobject.dart';
import '../b3constant.dart';

abstract class BaseNode extends BaseObject {
  void onEnter(Tick tick);
  void onOpen(Tick tick);
  Status onTick(Tick tick);
  void onClose(Tick tick);
  void onExit(Tick tick);

  BaseNode(String id, Map<String, dynamic> properties) : super(id, properties);
  Status execute(Tick tick) {
    enter(tick);

    var isOpenObj = tick.blackboard.get("isOpen", tick.tree.id, id);
    if ((isOpenObj is! bool) || !(isOpenObj)) {
      open(tick);
    }

    var status = this.tick(tick);

    if (status != Status.RUNNING) {
      close(tick);
    }

    exit(tick);

    return status;
  }

  void enter(Tick tick) {
    tick.enterNode(this);
    onEnter(tick);
  }

  void open(Tick tick) {
    tick.openNode(this);
    tick.blackboard.set("isOpen", true, tick.tree.id, id);
    onOpen(tick);
  }

  Status tick(Tick tick) {
    tick.tickNode(this);
    return onTick(tick);
  }

  void close(Tick tick) {
    tick.closeNode(this);
    tick.blackboard.set("isOpen", false, tick.tree.id, id);
    onClose(tick);
  }

  void exit(Tick tick) {
    tick.exitNode(this);
    onExit(tick);
  }
}
