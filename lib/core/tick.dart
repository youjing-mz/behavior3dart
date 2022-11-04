import 'basenode.dart';
import 'blackboard.dart';
import 'behaviortree.dart';

class Tick {
  Blackboard blackboard = Blackboard();
  late BehaviorTree tree;
  final List<BaseNode> openNodes = [];
  int nodeCount = 0;
  int deltaTime = 16;

  void enterNode(BaseNode node) {
    nodeCount++;
  }

  void openNode(BaseNode node) {
    openNodes.add(node);
  }

  void tickNode(BaseNode node) {}

  void closeNode(BaseNode node) {
    openNodes.removeLast();
  }

  void exitNode(BaseNode node) {
    --nodeCount;
  }

  int getCurTime() {
    return DateTime.now().millisecondsSinceEpoch;
  }
}
