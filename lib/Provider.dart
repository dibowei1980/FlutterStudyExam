import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class InherientedProvider<T> extends InheritedWidget {
  InherientedProvider({@required this.data, Widget child})
      : super(child: child);

  final T data;

  @override
  bool updateShouldNotify(InherientedProvider<T> oldWidget) {
    return true;
  }
}

class ChangeNotifierProvider<T extends ChangeNotifier> extends StatefulWidget {
  ChangeNotifierProvider({Key key, this.data, this.child});

  final T data;
  final Widget child;

  static T of<T>(BuildContext context, {bool license: true}) {
    final provider = (license
        ? context.dependOnInheritedWidgetOfExactType<InherientedProvider<T>>()
        : context.getElementForInheritedWidgetOfExactType<
            InherientedProvider<T>>()?.widget) as InherientedProvider<T>;
    return provider.data;
  }

  @override
  _ChangeNotifierProviderState<T> createState() =>
      _ChangeNotifierProviderState<T>();
}

class _ChangeNotifierProviderState<T extends ChangeNotifier>
    extends State<ChangeNotifierProvider<T>> {
  void _update() => setState(() {});

  @override
  void initState() {
    super.initState();
    widget.data.addListener(_update);
  }

  @override
  void didUpdateWidget(ChangeNotifierProvider<T> oldWidget) {
    if (oldWidget.data != widget.data) {
      oldWidget.data.removeListener(_update);
      widget.data.addListener(_update);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    widget.data.removeListener(_update);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InherientedProvider<T>(
      data: widget.data,
      child: widget.child,
    );
  }
}

//*****以下为使用ChangeNotifirProvider的实例***** */
class Item {
  Item(this.price, this.count);
  double price;
  int count;
}

class CartModel extends ChangeNotifier {
  final _items = <Item>[];
  UnmodifiableListView<Item> get items => UnmodifiableListView<Item>(_items);

  double get totolPrice =>
      _items.fold(0, (value, item) => value + item.count * item.price);

  void add(Item item) {
    _items.add(item);
    notifyListeners();
  }
}

class ProviderExamApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProviderRouteWidget(
      ),
    );
  }
}

class ProviderRouteWidget extends StatefulWidget {
  @override
  _ProviderRouteState createState() => _ProviderRouteState();
}

class Consumer<T extends ChangeNotifier> extends StatelessWidget {
  Consumer({Key key, @required this.builder, Widget child});

  final Function(BuildContext, T) builder;

  @override
  Widget build(BuildContext context) {
    return builder(context, ChangeNotifierProvider.of<T>(context));
  }
}

class _ProviderRouteState extends State<ProviderRouteWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ChangeNotifierProvider<CartModel>(
        data: CartModel(),
        child: Builder(
          builder: (context) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Consumer<CartModel>(
                    builder: (context,cart) => Text('总价:${cart.totolPrice}')),
                Builder(
                  builder: (context) {
                    return RaisedButton(
                      child: Text('添加货物'),
                      onPressed: () {
                        var cart = ChangeNotifierProvider.of<CartModel>(context,
                            license: false);
                        cart.add(Item(20.0, 1));
                      },
                    );
                  },
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
