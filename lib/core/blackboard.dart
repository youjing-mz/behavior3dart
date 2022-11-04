typedef KVStore = Map<String, dynamic>;

class TreeMemory {
  KVStore store = {};
  Map<String, KVStore> nodeMemory = {};
  List<String> openNodes = [];
  int traversalDepth = 0;
  int traversalCycle = 0;

  dynamic getNodeMemoryValue(String key) {
    KVStore? value = nodeMemory[key];
    if (value == null) {
      value = {};
      nodeMemory[key] = value;
    }
    return value;
  }
}

class Blackboard {
  Map<String, dynamic> baseMemory = <String, dynamic>{};
  Map<String, TreeMemory> treeMemory = {};

  TreeMemory _getTreeMemory(String treeScope) {
    var tree = treeMemory[treeScope];
    if (tree == null) {
      tree = TreeMemory();
      treeMemory[treeScope] = tree;
    }

    return tree;
  }

  dynamic _getMemory(String? treeScope, String? nodeScope) {
    if (treeScope != null) {
      var treeMemory = _getTreeMemory(treeScope);
      if (nodeScope != null) {
        return treeMemory.getNodeMemoryValue(nodeScope);
      }
      return treeMemory.store;
    }

    return baseMemory;
  }

  void set(String key, dynamic value, String? treeScope, String? nodeScope) {
    var memory = _getMemory(treeScope, nodeScope);
    memory[key] = value;
  }

  dynamic get(String key, String? treeScope, String? nodeScope) {
    var memory = _getMemory(treeScope, nodeScope);
    return memory[key];
  }
}
