import '../core/decorator.dart';
import '../core/tick.dart';
import '../b3constant.dart';

class Inverter extends Decorator {
  Inverter.init(String id, Map<String, dynamic> properties)
      : super(id, properties) {
    name = "Inverter";
  }

  @override
  void onEnter(Tick tick) {}

  @override
  void onOpen(Tick tick) {}

  @override
  Status onTick(Tick tick) {
    if (child == null) {
      return Status.ERROR;
    }

    var status = child!.execute(tick);

    if (status == Status.SUCCESS) {
      status = Status.FAILURE;
    } else if (status == Status.FAILURE) {
      status = Status.SUCCESS;
    }

    return status;
  }

  @override
  void onClose(Tick tick) {}

  @override
  void onExit(Tick tick) {}
}
