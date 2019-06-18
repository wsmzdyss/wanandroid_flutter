import 'package:flutter/material.dart';

class CommonListView extends StatefulWidget {
  CommonListView(
      {Key key,
      @required this.itemCount,
      @required this.itemWidget,
      @required this.onRefresh,
      this.onLoadMore,
      this.divider,
      this.scrollFromTopOffSet = 200})
      : super(key: key);

  final IndexedWidgetBuilder itemWidget;
  final Widget divider;
  final int itemCount;
  final double scrollFromTopOffSet;
  final RefreshCallback onRefresh;
  final Future<void> Function() onLoadMore;

  @override
  State<StatefulWidget> createState() {
    return _ListViewState();
  }
}

class _ListViewState extends State<CommonListView> {
  ScrollController _controller = ScrollController();
  bool _isLoadMore = false;
  bool _showToTopBtn = false;

  Widget divider = Divider(height: 1, color: Colors.grey);

  @override
  void initState() {
    _controller.addListener(() {
      //滚动到底部
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        //TODO 此setState不会生效
        setState(() {
          _isLoadMore = true;
        });
        widget.onLoadMore().then((value) {
          setState(() {
            _isLoadMore = false;
          });
        });
      }

      if (_controller.offset < widget.scrollFromTopOffSet && _showToTopBtn) {
        setState(() {
          _showToTopBtn = false;
        });
      } else if (_controller.offset >= widget.scrollFromTopOffSet &&
          _showToTopBtn == false) {
        setState(() {
          _showToTopBtn = true;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RefreshIndicator(
          child: ListView.separated(
            itemBuilder: (context, index) {
              if (index < widget.itemCount) {
                return widget.itemWidget(context, index);
              } else {
                return _isLoadMore
                    ? Container(
                        height: 50,
                        child: Center(
                          child: Text(
                            "加载更多",
                            style:
                                TextStyle(color: Theme.of(context).accentColor),
                          ),
                        ),
                      )
                    : Container(width: 0, height: 0);
              }
            },
            separatorBuilder: (context, index) {
              return widget.divider ?? divider;
            },
            itemCount: widget.itemCount + 1,
            controller: _controller,
          ),
          onRefresh: widget.onRefresh,
        ),
        floatingActionButton: _showToTopBtn
            ? FloatingActionButton(
                child: Icon(Icons.arrow_upward),
                onPressed: () {
                  _controller.animateTo(.0,
                      duration: Duration(milliseconds: 200),
                      curve: Curves.ease);
                },
              )
            : null);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
