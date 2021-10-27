import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      home: HomeWidget(),
    );
  }
}

class AppState {
  bool loading;
  String user;
  AppState(this.loading, this.user);
}

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final AppState app = AppState(true, '');

  _delay() {
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        app.loading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _delay();
  }

  @override
  Widget build(BuildContext context) {
    if (app.loading) return _loading();
    if (app.user.isEmpty) return _login();
    return _main();
  }

  Widget _loading() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loading...'),
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _login() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('ID'),
            Text('Password'),
            RaisedButton(
              child: Text('login'),
              onPressed: () {
                setState(() {
                  app.loading = true;
                  app.user = 'yoonki';
                  _delay();
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _main() {
    print(app.loading);
    return Scaffold(
      appBar: AppBar(
        title: Text(app.user),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                app.loading = true;
                app.user = '';
                _delay();
              });
            },
            icon: Icon(Icons.login),
          )
        ],
      ),
      body: Center(
        child: Text('Main Contents'),
      ),
    );
  }
}
