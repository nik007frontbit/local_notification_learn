import 'package:flutter/material.dart';

import '../routes.dart';

class AnimationFirstPage extends StatefulWidget {
  AnimationFirstPage({super.key});

  @override
  State<AnimationFirstPage> createState() => _AnimationFirstPageState();
}

class _AnimationFirstPageState extends State<AnimationFirstPage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Color?> animationColor;
  late Animation<double> animationSize;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    animationColor = ColorTween(
      begin: Colors.grey,
      end: Colors.red,
    ).animate(animationController);

    animationSize = TweenSequence<double>([
      TweenSequenceItem<double>(tween: Tween(begin: 30, end: 50), weight: 50),
      TweenSequenceItem<double>(tween: Tween(begin: 50, end: 30), weight: 50),
    ]).animate(animationController);

    animationController.addListener(() {
      print(animationController.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Animations")),
      body: Column(
        children: [
          TweenAnimationBuilder(
            tween: Tween<double>(
              end: 1,
              begin: 0,
            ),
            duration: const Duration(seconds: 3),
            builder: (context, double value, child) => Padding(
              padding: EdgeInsets.all(value * 30),
              child: const Text(
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
          AnimatedBuilder(
            animation: animationController,
            builder: (context, child) => GestureDetector(
               onTap: () {
                 animationController.status==AnimationStatus.completed?animationController.reverse():animationController.forward();
                 print(animationController.status);
               },
              child: Icon(Icons.heart_broken_sharp,
                  color: animationColor.value, size: animationSize.value),
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
    _listKey.currentState
        ?.insertItem(0, duration: const Duration(milliseconds: 300));
  }

  void _removeItem(int index) {
    int removedItem = _items.removeAt(index);
    _listKey.currentState?.removeItem(
      index,
      (context, animation) => _buildItem(context, removedItem, animation),
      duration: const Duration(milliseconds: 300),
    );
  }

  Widget _buildItem(
      BuildContext context, int item, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: ListTile(
        key: ValueKey<int>(item),
        title: Text('Item $item'),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () => _removeItem(_items.indexOf(item)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated List Example'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _addItem,
            child: const Text('Add Item'),
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
