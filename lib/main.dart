import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

////////////////////////////////////
class MyModel extends ChangeNotifier {
  int _value = 0;

  int get value => _value;

  void setValue(int newValue) {
    _value = newValue;
    notifyListeners();
  }
}

class MyChildWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final myModel = Provider.of<MyModel>(context);
    return Text('Value: ${myModel.value}');
  }
}

class MyAppProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MyModel(),
      child: MyChildWidget(),
    );
  }
}

///////////////////////////////////////////
class MyInheritedWidget extends InheritedWidget {
  final int value;

  MyInheritedWidget({
    required this.value,
    required Widget child,
  }) : super(child: child);

  static MyInheritedWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>()!;
  }

  @override
  bool updateShouldNotify(MyInheritedWidget oldWidget) {
    return oldWidget.value != value;
  }
}

class MyChildInheritedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final inheritedValue = MyInheritedWidget.of(context).value;

    return Text('Inherited Value: $inheritedValue');
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(height: 100),
          MyAppProvider(),
          MyInheritedWidget(
            value: 42,
            child: MyChildInheritedWidget(),
          ),
        ],
      ),
    );
  }
}
