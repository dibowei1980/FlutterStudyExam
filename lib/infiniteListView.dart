import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:sprintf/sprintf.dart';

class InfiniteListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _InfiniteListViewState();
  }
}

class _InfiniteListViewState extends State<InfiniteListView> {
  static const String _loadingFlag = '****Loading****';
  var _words = [_loadingFlag];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '无限列表测试',
      home: Scaffold(
        appBar: AppBar(title: Text('ListViewTest')),
        body: Container(
          alignment: Alignment.center,
          child: Scrollbar(
            child: ListView.separated(
              itemCount: _words.length,
              separatorBuilder: (context, idx) => Divider(color: Colors.blue),
              itemBuilder: (context, idx) {
                if (idx >= _words.length) {
                  return null;
                } else {
                  if (_words[idx] == _loadingFlag) {
                    if (_words.length < 100) {
                      _recieveWords(100);
                      return Container(
                        padding: EdgeInsets.all(16.0),
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: 24.0,
                          height: 24.0,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.0,
                          ),
                        ),
                      );
                    } else {
                      return ListTile(title: Text('没有更多数据了.'));
                    }
                  }
                  return ListTile(
                      title: Text(
                          sprintf('%i %s', [idx, _words[idx]]).toString()));
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  void _recieveWords(int limitCount) {
    if (_words.length >= limitCount) return;
    Future.delayed(Duration(seconds: 2)).then((e) {
      _words.insertAll(_words.length - 1,
          generateWordPairs().take(20).map((s) => s.asPascalCase).toList());
      setState(() {});
    });
  }
}
