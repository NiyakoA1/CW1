import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CounterImageToggleApp(),
    );
  }
}

class CounterImageToggleApp extends StatefulWidget {
  @override
  _CounterImageToggleAppState createState() => _CounterImageToggleAppState();
}

class _CounterImageToggleAppState extends State<CounterImageToggleApp>
    with SingleTickerProviderStateMixin {
  int _counter = 0;
  bool _isFirstImage = true;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _toggleImage() {
    setState(() {
      _isFirstImage = !_isFirstImage;
      _animationController.forward(from: 0.0);
    });
  }

  void _resetApp() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Reset"),
          content: Text("Are you sure you want to reset the counter and image?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _counter = 0;
                  _isFirstImage = true;
                });
                Navigator.of(context).pop();
              },
              child: Text("Reset"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Counter & Image Toggle App")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Counter: $_counter',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _incrementCounter,
              child: Text("Increment"),
            ),
            SizedBox(height: 40),
            FadeTransition(
              opacity: _fadeAnimation,
              child: Image.asset(
                _isFirstImage ? 'assets/image1.jpeg' : 'assets/image2.jpeg',
                height: 200,
                width: 200,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _toggleImage,
              child: Text("Toggle Image"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _resetApp,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text("Reset"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
