import 'package:behavior3dart/behavior3dart.dart' as behavior3;
import 'dart:io';

class Log extends behavior3.BaseNode {
  late String info;
  int i = 1;
  Log.init(String id, Map<String, dynamic> properties) : super(id, properties) {
    name = "Log";
    info = properties['info'] as String;
  }

  @override
  void onEnter(behavior3.Tick tick) {}

  @override
  void onOpen(behavior3.Tick tick) {}

  @override
  behavior3.Status onTick(behavior3.Tick tick) {
    print((i++).toString() + " " + info + " " + id);
    return behavior3.Status.SUCCESS;
  }

  @override
  void onClose(behavior3.Tick tick) {}

  @override
  void onExit(behavior3.Tick tick) {}
}

void main() {
  runMain();
}

Future<void> runMain() async {
  File file = File('asset/project.json');
  try {
    String content = await file.readAsString();
    print(content);
    var register = behavior3.createDefaultStructMaps();
    register.registerFactory('Log', Log.init);
    var tree = await behavior3.loadTreeCfg(content, register);
    var blackboard = behavior3.createDefaultBlackboard();
    tree.tick(blackboard);
    tree.tick(blackboard);
    tree.tick(blackboard);
  } catch (e) {
    print(e);
  }
}
