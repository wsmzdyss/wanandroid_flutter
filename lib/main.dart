import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/util/theme_uitl.dart';

import 'ui/home_paget.dart';
import 'ui/mine_page.dart';
import 'ui/tree_page.dart';

void main() => runApp(MyApp());

int _selPageIndex = 0;

const bottomItems = ["首页", "发现", "我的"];

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WanAndroid',
      theme: ThemeData(
        primarySwatch: ThemeUtil.curThemeColor,
      ),
      home: MyHomePage(title: 'WanAndroid'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var _pageItems = [HomeWidget(), TreeWidget(), MineWidget()];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(bottomItems[_selPageIndex]),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {})
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text(bottomItems[0])),
          BottomNavigationBarItem(icon: Icon(Icons.subject), title: Text(bottomItems[1])),
          BottomNavigationBarItem(icon: Icon(Icons.person), title: Text(bottomItems[2])),
        ],
        currentIndex: _selPageIndex,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),
      body: new IndexedStack(children: _pageItems, index: _selPageIndex),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selPageIndex = index;
    });
  }

}
