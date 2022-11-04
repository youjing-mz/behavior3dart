import 'tick.dart';

import 'basenode.dart';
import 'composite.dart';
import 'decorator.dart';
import 'baseobject.dart';
import 'blackboard.dart';
import '../b3constant.dart';
import 'dart:math';

typedef BaseNodeConstructor = BaseNode Function(
    String id, Map<String, dynamic> properties);

class RegisterStructMaps {
  Map<String, BaseNodeConstructor> register = {};

  void registerFactory(String name, BaseNodeConstructor function) {
    register[name] = function;
  }

  BaseNode? createNode(
      String name, String id, Map<String, dynamic> properties) {
    var factory = register[name];
    if (factory == null) {
      return null;
    }

    return factory(id, properties);
  }
}

class BehaviorTreeNodeCfg {
  String id;
  String name;
  String category;
  String title;
  String description;
  List<String> children;
  String child;
  Map<String, dynamic> properties;

  BehaviorTreeNodeCfg.fromJson(Map<String, dynamic> parseMap)
      : id = parseMap["id"],
        name = parseMap["name"],
        category = parseMap["category"],
        title = parseMap["title"],
        description = parseMap["description"],
        child = parseMap["child"] ?? "",
        children = parseMap["children"] != null
            ? List<String>.from(parseMap["children"])
            : [],
        properties = parseMap["properties"];
}

class BehaviorTreeCfg {
  String id;
  String title;
  String description;
  String root;
  Map<String, dynamic> properties;
  List<BehaviorTreeNodeCfg> nodes;

  BehaviorTreeCfg.fromJson(Map<String, dynamic> parseMap)
      : id = parseMap["id"],
        title = parseMap["title"],
        description = parseMap["description"],
        root = parseMap["root"],
        nodes = (parseMap["nodes"] as Map)
            .entries
            .map((entry) => BehaviorTreeNodeCfg.fromJson(entry.value))
            .toList(),
        properties = parseMap["properties"];
}

class BehaviorTree extends BaseObject {
  BaseNode? root;

  BehaviorTree(String id, Map<String, dynamic> properties)
      : super(id, properties);

  void load(BehaviorTreeCfg treeCfg, RegisterStructMaps register) {
    title = treeCfg.title;
    description = treeCfg.description;
    properties = treeCfg.properties;
    Map<String, BaseNode> nodes = {};
    for (int i = 0; i < treeCfg.nodes.length; i++) {
      var nodeCfg = treeCfg.nodes[i];
      var node =
          register.createNode(nodeCfg.name, nodeCfg.id, nodeCfg.properties);
      if (node != null) {
        nodes[nodeCfg.id] = node;
      }
    }

    for (int i = 0; i < treeCfg.nodes.length; i++) {
      var nodeCfg = treeCfg.nodes[i];
      var node = nodes[nodeCfg.id];
      if (node == null) {
        continue;
      }
      if (node.category == COMPOSITE) {
        for (var j = 0; j < nodeCfg.children.length; j++) {
          var cid = nodeCfg.children[j];
          (node as Composite).addChild(nodes[cid]!);
        }
      } else if (node.category == DECORATOR) {
        var cid = nodeCfg.child;
        (node as Decorator).setChild(nodes[cid]!);
      }
    }

    root = nodes[treeCfg.root];
  }

  Status tick(Blackboard blackboard) {
    var tick = Tick();

    tick.blackboard = blackboard;
    tick.tree = this;

    var state = root!.execute(tick);

    var lastOpenNodesObj = blackboard.get("openNodes", id, null);
    List<BaseNode>? lastOpenNodes;
    var lastOpenNodesLen = 0;
    if (lastOpenNodesObj != null) {
      lastOpenNodes = lastOpenNodesObj as List<BaseNode>;
      lastOpenNodesLen = lastOpenNodes.length;
    }
    var currOpenNodes = List<BaseNode>.from(tick.openNodes);

    var start = 0;
    for (var i = 0; i < min(lastOpenNodesLen, currOpenNodes.length); i++) {
      start = i + 1;
      if (lastOpenNodes![i] != currOpenNodes[i]) {
        break;
      }
    }

    for (var i = lastOpenNodesLen - 1; i >= start; i--) {
      lastOpenNodes![i].close(tick);
    }

    blackboard.set('openNodes', currOpenNodes, id, null);
    blackboard.set('nodeCount', tick.nodeCount, id, null);

    return state;
  }
}
