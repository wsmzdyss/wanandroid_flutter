import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/entity/tree_entity.dart';
import 'package:wanandroid_flutter/net/dio_api_service.dart';
import 'package:wanandroid_flutter/ui/tree/tree_detail_page.dart';
import 'package:wanandroid_flutter/widget/refresh_loadmore_listview.dart';

class TreeWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TreeWidgetState();
  }
}

class TreeWidgetState extends State<TreeWidget> {
  List<TreeData> _treeList = List();

  @override
  void initState() {
    getTree();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonListView(
      itemCount: _treeList.length,
      onRefresh: this._onRefresh,
      itemWidget: (context, index) {
        return InkWell(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Align(
                        child: Text(
                          _treeList[index].name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        alignment: Alignment.centerLeft,
                      ),
                      Align(
                        child: buildChildWidget(index),
                        alignment: Alignment.centerLeft,
                      )
                    ],
                  ),
                ),
                Icon(Icons.chevron_right)
              ],
            ),
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return TreeDetailWidget(_treeList[index]);
            }));
          },
        );
      },
    );
  }

  Widget buildChildWidget(index) {
    List<Widget> widgets = List();
    Widget item;
    for (var it in _treeList[index].children) {
      item = Chip(
          label: Text(
            it.name,
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Theme.of(context).primaryColor);
      widgets.add(item);
    }
    return Wrap(
      children: widgets,
      spacing: 16,
    );
  }

  Future _onRefresh() async {
    getTree();
  }

  getTree() {
    ApiService.getTree().then((res) {
      setState(() {
        _treeList = res;
      });
    });
  }
}
