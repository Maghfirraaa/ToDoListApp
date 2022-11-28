import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todolistapp/HomePage.dart';
import 'package:todolistapp/catalog.dart';
import 'package:todolistapp/onboarding.dart';
import 'Service/Service.dart';
import 'SharedPref.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'model/model.dart';

class homePage extends StatefulWidget {
  // late String param;
  // landingPage({Key? key, required this.param}) : super(key: key);
  Function setTheme;
  homePage({Key? key, required this.setTheme}) : super(key: key);
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  void setTheme() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  Widget card() {
    return Card(
      color: Colors.blue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        height: 144,
        width: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("image/image2.png"), fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(16)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "ToDoList App",
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              "Get Solution for" + " Managing Time",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 16, left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            card(),
            SizedBox(
              height: 24,
            ),
            Text(
              "Popular Articles",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Padding(padding: EdgeInsets.only(bottom: 5)),
            FutureBuilder<Map<String, dynamic>>(
              future: Service.getDataHome(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: Text('Please wait its loading...'));
                } else {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                    // return Text(snapshot.data.toString());
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: GridView.builder(
                          itemCount: snapshot.data!.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                          ),
                          itemBuilder: (context, index) {
                            return Stack(
                              children: [
                                Container(
                                  // color: Colors.orange,
                                  width: double.infinity,
                                  height: double.infinity,

                                  child: Image.network(
                                    "${snapshot.data![index].gambar}",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                        width: double.infinity,
                                        color: Colors.black26,
                                        child: Text(
                                          "${snapshot.data![index].tittle}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.white),
                                        )),
                                    Container(
                                        width: double.infinity,
                                        color: Colors.black26,
                                        child: Text(
                                          "${snapshot.data![index].price}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.white),
                                        )),
                                  ],
                                )
                              ],
                            );
                          }),
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
