import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learning_app/quotes.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Home',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blueGrey,
      ),
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
    );
  }

  final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) =>
            MyHomePage(title: 'Learning stuff'),
      ),
      GoRoute(
        path: '/list',
        builder: (BuildContext context, GoRouterState state) =>
            const QuotesPage(title: 'Quotes'),
      ),
    ],
  );
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final Uri _url = Uri.parse(
      'https://www.linkedin.com/in/kristofer-k%C3%A4osaar-609b52189/');

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _doubleIncrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter += 1;
    });
  }

  void _launchUrl() async {
    if (!await launchUrl(widget._url, mode: LaunchMode.externalApplication))
      throw 'Could not launch';
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Container(
          margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
          child: Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: Column(
              // Column is also a layout widget. It takes a list of children and
              // arranges them vertically. By default, it sizes itself to fit its
              // children horizontally, and tries to be as tall as its parent.
              //
              // Invoke "debug painting" (press "p" in the console, choose the
              // "Toggle Debug Paint" action from the Flutter Inspector in Android
              // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
              // to see the wireframe for each widget.
              //
              // Column has various properties to control how it sizes itself and
              // how it positions its children. Here we use mainAxisAlignment to
              // center the children vertically; the main axis here is the vertical
              // axis because Columns are vertical (the cross axis would be
              // horizontal).
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'You have pushed the + button this many times:',
                ),
                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.headline4,
                ),
                const Spacer(),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                        width: 200,
                        height: 50,
                        child: MaterialButton(
                          onPressed: () => context.push('/list'),
                          color: Colors.lightBlueAccent,
                          padding: const EdgeInsets.all(16.0),
                          child: const Text("Navigate to Quotes"),
                        ))),
                const SizedBox(height: 20.0),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                        width: 200,
                        height: 50,
                        child: MaterialButton(
                          onPressed: () => _launchUrl(),
                          color: Colors.blueAccent,
                          padding: const EdgeInsets.all(16.0),
                          child: const Text("Creator's LinkedIn"),
                        )))
              ],
            ),
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: _doubleIncrementCounter,
        hoverColor: Colors.blue,
        tooltip: 'Click me!',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
