import 'package:flutter/material.dart';

class TabPageExamApp extends StatefulWidget {
  @override
  _TabPageExamAppState createState() => _TabPageExamAppState();
}

class _TabPageExamAppState extends State<TabPageExamApp>
    with SingleTickerProviderStateMixin {
  var tabText = ['语文', '数学', '英语'];
  TabController _tabController;

  int _selectIndex = 1;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabText.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('TabPageTest'),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.share), onPressed: () {}),
          ],
          leading: Builder(
            builder: (context) {
              return IconButton(
                icon: Icon(Icons.dashboard, color: Colors.white),
                onPressed: () {}, // => Scaffold.of(context).openDrawer(),
              );
            },
          ),
          bottom: TabBar(
            controller: _tabController,
            tabs: tabText.map((e) => Tab(text: e)).toList(),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: tabText.map((e) {
            return Center(child: Text(e, style: TextStyle(fontSize: 16.0)));
          }).toList(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), title: Text('Home')),
            BottomNavigationBarItem(
                icon: Icon(Icons.school), title: Text('School')),
            BottomNavigationBarItem(
                icon: Icon(Icons.business), title: Text('Business'))
          ],
          onTap: (index) => setState(() {
            _selectIndex = index;
          }),
          currentIndex: _selectIndex,
          fixedColor: Colors.blue,
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {},
        ),
      ),
    );
  }
}
