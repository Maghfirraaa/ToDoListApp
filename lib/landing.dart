import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todolistapp/HomePage.dart';
import 'package:todolistapp/catalog.dart';
import 'package:todolistapp/onboarding.dart';

import 'SharedPref.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

class landingPage extends StatefulWidget {
  // late String param;
  // landingPage({Key? key, required this.param}) : super(key: key);
  Function setTheme;
  landingPage({Key? key, required this.setTheme}) : super(key: key);
  State<landingPage> createState() => _landingPageState();
}

class _landingPageState extends State<landingPage> {
  // final String ;
  // _landingPageState({required this.param});
  bool isDarkmode = SharedPref.pref?.getBool('isDarkmode') ?? false;
  ThemeData themeData = ThemeData.light();
  /* fungsi mengubah tema sesuai inputan parameter */
  void setTheme(bool isDarkmode) {
    setState(() {
      /* jika isDarkmode true maka ThemeData adalah dark dan sebaliknya */
      themeData = (isDarkmode) ? ThemeData.dark() : ThemeData.light();
      /* simpan nilai boolean pada shared preferences */
      SharedPref.pref?.setBool('isDarkmode', isDarkmode);
      print(isDarkmode);
    });
  }

  int _bottomNavCurrentIndex = 0;

  @override
  void initState() {
    // print(param.toString());
    // super.initState();
    bool isDarkmode = SharedPref.pref?.getBool('isDarkmode') ?? false;
    setTheme(isDarkmode);

    super.initState();
  }

  late List<Widget> container = [
    homePage(setTheme: setTheme),
    Catalog(),
    Catalog(),
    // Catalog(param: param),
    // Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue[400],
        title: const Text(
          "ToDoListApp",
          style: TextStyle(color: Colors.white),
        ),
        // automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.brightness_4_rounded,
                color: const Color.fromARGB(255, 253, 251, 251)),
            padding: EdgeInsets.only(right: 25),
            onPressed: () {
              isDarkmode = !isDarkmode;
              widget.setTheme(isDarkmode);
            },
          )
        ],
      ),
      body: container[_bottomNavCurrentIndex],
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('ToDoListApp'),
            ),
            ListTile(
                leading: Icon(Icons.settings),
                title: const Text('pengaturan'),
                onTap: () => print('Tap Trash menu')),
            new Divider(),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              trailing: new Icon(Icons.cancel),
              title: const Text('LOGOUT'),
              onTap: () {
                // Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const onboarding()));
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _bottomNavCurrentIndex,
        showElevation: true,
        itemCornerRadius: 24,
        curve: Curves.easeIn,
        onItemSelected: (index) =>
            setState(() => _bottomNavCurrentIndex = index),
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: Icon(Icons.home),
            title: Text('Beranda'),
            activeColor: Colors.blue,
            inactiveColor: Colors.black,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.assignment),
            title: Text('Catalog'),
            activeColor: Colors.blue,
            inactiveColor: Colors.black,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.person),
            title: Text('Account'),
            activeColor: Colors.blue,
            inactiveColor: Colors.black,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
