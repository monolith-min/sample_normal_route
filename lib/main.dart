import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        FirstScreen.routeName: (context) => FirstScreen(),
        SecondScreen.routeName: (context) => SecondScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == ThirdScreen.routeName) {
          final ScreenArguments args = settings.arguments as ScreenArguments;

          return MaterialPageRoute(
            builder: (context) {
              return ThirdScreen(
                data: args,
              );
            },
          );
        }
      },
      title: 'Flutter Demo',
    );
  }
}

class FirstScreen extends StatelessWidget {
  static const routeName = '/';

  const FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Screen'),
      ),
      body: Container(
        child: Column(
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/second');
                },
                child: Text("navigate 1", style: TextStyle(fontSize: 30),)),
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    ThirdScreen.routeName,
                    arguments: ScreenArguments(
                      'Accept Arguments Screen',
                      'This message is extracted in the onGenerateRoute function.',
                    ),
                  );
                },
                child: Text("sendData", style: TextStyle(fontSize: 30)))
          ],
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  static const routeName = '/second';

  const SecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SecondScreen'),
      ),
      body: Container(
        child: Text("second 2"),
      ),
    );
  }
}

class ThirdScreen extends StatelessWidget {
  static const routeName = '/extractArguments';
  final ScreenArguments data;

  const ThirdScreen({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ThirdScreen'),
      ),
      body: Container(
        child: Text("title : ${data.title}   message : ${data.message}"),
      ),
    );
  }
}

class ScreenArguments {
  final String title;
  final String message;

  ScreenArguments(this.title, this.message);
}
