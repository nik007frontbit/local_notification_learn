import 'package:flutter/material.dart';

import '../routes.dart';

class AnimationFirstPage extends StatelessWidget {
  const AnimationFirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Animations")),
      body: Column(
        children: [
          TweenAnimationBuilder(
            tween: Tween<double>(
              end: 1,
              begin: 0,
            ),
            duration: Duration(seconds: 3),
            builder: (context, double value, child) => Padding(
              padding: EdgeInsets.all(value * 30),
              child: Text(
                "Tween",
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, Routes.aniSecond),
            child: Hero(
              tag: "tag",
              child: SizedBox(
                  width: 100,
                  height: 100,
                  child: Image.asset("assets/dog1.png")),
            ),
          ),
          Expanded(child: AnimatedListExample()),
        ],
      ),
    );
  }
}

class AnimationSecondPage extends StatelessWidget {
  const AnimationSecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(tag: "tag", child: Image.asset("assets/dog1.png")),
    );
  }
}

class AnimatedListExample extends StatefulWidget {
  @override
  _AnimatedListExampleState createState() => _AnimatedListExampleState();
}

class _AnimatedListExampleState extends State<AnimatedListExample> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<int> _items = List.generate(5, (index) => index);
  int _counter = 5;

  void _addItem() {
    _items.insert(0, _counter++);
    _listKey.currentState?.insertItem(0, duration: Duration(milliseconds: 300));
  }

  void _removeItem(int index) {
    int removedItem = _items.removeAt(index);
    _listKey.currentState?.removeItem(
      index,
          (context, animation) => _buildItem(context, removedItem, animation),
      duration: Duration(milliseconds: 300),
    );
  }

  Widget _buildItem(BuildContext context, int item, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: ListTile(
        key: ValueKey<int>(item),
        title: Text('Item $item'),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () => _removeItem(_items.indexOf(item)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animated List Example'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _addItem,
            child: Text('Add Item'),
          ),
          Expanded(
            child: AnimatedList(
              key: _listKey,
              initialItemCount: _items.length,
              itemBuilder: (context, index, animation) {
                return _buildItem(context, _items[index], animation);
              },
            ),
          ),
        ],
      ),
    );
  }
}