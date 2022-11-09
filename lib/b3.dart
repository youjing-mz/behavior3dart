//加载
import 'core/behaviortree.dart';
import 'core/blackboard.dart';
import 'dart:convert';
import 'dart:async';
import 'composites/sequence.dart';
import 'composites/priority.dart';
import 'composites/memsequence.dart';
import 'composites/mempriority.dart';
import 'actions/error.dart';
import 'actions/failer.dart';
import 'actions/runner.dart';
import 'actions/succeeder.dart';
import 'actions/wait.dart';

import 'decorators/inverter.dart';
import 'decorators/limiter.dart';
import 'decorators/maxtime.dart';
import 'decorators/repeater.dart';
import 'decorators/repeatuntilfailure.dart';
import 'decorators/repeatuntilsuccess.dart';

RegisterStructMaps createDefaultStructMaps() {
  var baseRegister = RegisterStructMaps();
  baseRegister.register['Sequence'] = Sequence.init;
  baseRegister.register['Priority'] = Priority.init;
  baseRegister.register['MemSequence'] = MemSequence.init;
  baseRegister.register['MemPriority'] = MemPriority.init;

  baseRegister.register['Error'] = Error.init;
  baseRegister.register['Failer'] = Failer.init;
  baseRegister.register['Runner'] = Runner.init;
  baseRegister.register['Succeeder'] = Succeeder.init;
  baseRegister.register['Wait'] = Wait.init;

  baseRegister.register['Inverter'] = Inverter.init;
  baseRegister.register['Limiter'] = Limiter.init;
  baseRegister.register['MaxTime'] = MaxTime.init;
  baseRegister.register['Repeater'] = Repeater.init;
  baseRegister.register['RepeatUntilFailure'] = RepeatUntilFailure.init;
  baseRegister.register['RepeatUntilSuccess'] = RepeatUntilSuccess.init;
  return baseRegister;
}

Blackboard createDefaultBlackboard() {
  return Blackboard();
}

Future<BehaviorTree> loadTreeCfg(
    String content, RegisterStructMaps register) async {
  // 解析 json 字符串，返回的是 Map<String, dynamic> 类型
  final jsonMap = json.decode(content);

  BehaviorTreeCfg treeCfg = BehaviorTreeCfg.fromJson(jsonMap);
  BehaviorTree tree = BehaviorTree(treeCfg.id, treeCfg.properties);
  tree.load(treeCfg, register);
  return tree;
}
