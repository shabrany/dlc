import 'package:flutter/material.dart';
import './ui/lessons.dart';
import './ui/app_colors.dart' as AppColors;

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      builder: (context, child) => _mediaQuery(context, child),
      title: 'Digitale Rijleskaart',
      home: new MainPage(),
      theme: ThemeData(
        primaryColor: AppColors.primary,
      ),
    );
  }

  MediaQuery _mediaQuery(context, child) {
    return MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
        child: child
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {

  PageController _pageController;

  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new PageView(
        children: <Widget>[
          new Dashboard(),
          new Lessons(),
          new Skills(),
        ],
        controller: _pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: new BottomNavigationBar(
        items: [
          new BottomNavigationBarItem(icon: Icon(Icons.timeline), title: Text("Voortgang")),
          new BottomNavigationBarItem(icon: Icon(Icons.schedule), title: Text("Afspraken")),
          new BottomNavigationBarItem(icon: Icon(Icons.star), title: Text("Vaardigheden")),
        ], 
        onTap: navigationTapped, 
        currentIndex: _currentPage,
      ),
    );
  }

  void navigationTapped(int page) {
    _pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease
    );
  }

  void onPageChanged(int page) {
    setState(() {
      this._currentPage = page;
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController = new PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }
}

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text('Voortgang')),
      body: new Container(
        alignment: Alignment.topLeft,
        child: Text('Dashboard screen'),
      ),
    );
  }
}

class Skills extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text('Vaardigheden')),
      body: new Container(
        alignment: Alignment.topLeft,
        child: Text('Lijst met alle auto skilss'),
      ),
    );
  }
}
