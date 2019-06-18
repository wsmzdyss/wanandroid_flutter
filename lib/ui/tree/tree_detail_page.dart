import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/entity/tree_entity.dart';
import 'package:wanandroid_flutter/ui/tree/tree_content_widget.dart';

class TreeDetailWidget extends StatefulWidget {
  final TreeData data;

  TreeDetailWidget(this.data);

  @override
  State createState() => TreeDetailState();
}

class TreeDetailState extends State<TreeDetailWidget>
    with SingleTickerProviderStateMixin {
  TreeData data;
  TabController _tabController;

  @override
  void initState() {
    this.data = widget.data;
    _tabController = TabController(length: data.children.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data.name),
        bottom: TabBar(
          tabs: data.children.map((it) {
            return Tab(text: it.name);
          }).toList(),
          controller: _tabController,
          isScrollable: true,
        ),
      ),
      body: TabBarView(
        children: data.children.map((item) {
          return TreeContentWidget(item.id);
        }).toList(),
        controller: _tabController,
      ),
    );
  }
}
