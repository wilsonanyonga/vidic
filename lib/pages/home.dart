import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:vidic/utils/auth.dart';
import 'package:vidic/widgets/card.dart';
import 'package:vidic/widgets/menu_bar.dart';
import 'package:vidic/widgets/navigation_rail.dart';
// import 'package:percent_indicator/percent_indicator.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  var mediaQsize, mediaQheight, mediaQwidth;
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  int _counter = 0;
  int _selectedIndex = 0;

  void _incrementCounter() {
    // setState(() {
    //   // This call to setState tells the Flutter framework that something has
    //   // changed in this State, which causes it to rerun the build method below
    //   // so that the display can reflect the updated values. If we changed
    //   // _counter without calling setState(), then the build method would not be
    //   // called again, and so nothing would appear to happen.
    //   _counter++;
    // });
  }

  @override
  Widget build(BuildContext context) {
    mediaQsize = MediaQuery.of(context).size;
    mediaQheight = mediaQsize.height;
    mediaQwidth = mediaQsize.width;

    Future<void> signOut() async {
      await Auth().signOut();
    }

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      // appBar: AppBar(
      //   // Here we take the value from the MyHomePage object that was created by
      //   // the App.build method, and use it to set our appbar title.
      //   title: Text(title),
      // ),
      body: Row(
        children: [
          // create a navigation rail
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraint) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  child: IntrinsicHeight(
                    child: WidgetNavigationRail(selectedIndex: _selectedIndex),
                  ),
                ),
              );
            },
            // child:
          ),

          // end of navigation rail

          const VerticalDivider(thickness: 1, width: 2),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                // mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // const Text('data'),
                  const MenuBarWidget(),
                  // Center(
                  //   child: Text('Page Number: $_selectedIndex'),
                  // ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Building Occupancy',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Wrap(
                            direction: Axis.horizontal,
                            alignment: WrapAlignment.center,
                            // runAlignment: WrapAlignment.center,
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              NewWidgetCardHome(),
                              NewWidgetCardHome(),
                              NewWidgetCardHome(),
                              NewWidgetCardHome(),
                              NewWidgetCardHome(),
                              // NewWidgetCardHome(),
                              // NewWidgetCardHome(),
                              // NewWidgetCardHome(),
                              // NewWidgetCardHome(),
                              // NewWidgetCardHome(),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Alpha House Tenants',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 40,
                          width: 250,
                          child: TextField(
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                                // borderSide: const BorderSide(
                                //   color: Colors.green,
                                //   width: 1.0,
                                // ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: const BorderSide(
                                  color: Colors.white,
                                  width: 1.0,
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.grey.shade300,
                              // input border should appear when data is being modified
                              // border: OutlineInputBorder(
                              //   borderRadius: BorderRadius.circular(10.0),
                              // ),
                              floatingLabelStyle:
                                  const TextStyle(color: Colors.black),
                              labelText: 'Search',
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 20,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                                leading: const Icon(Icons.person),
                                // trailing: const Text(
                                //   "GFG",
                                //   style: TextStyle(
                                //       color: Colors.green, fontSize: 15),
                                // ),
                                title: Row(
                                  children: [
                                    Text("Tenant $index"),
                                    const SizedBox(
                                      width: 50,
                                    ),
                                    Text("mymail$index@gmail.com"),
                                    const SizedBox(
                                      width: 50,
                                    ),
                                    Chip(
                                      label: const Text(
                                        '1st Floor',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      backgroundColor: Colors.pink[300],
                                    ),
                                    const SizedBox(
                                      width: 50,
                                    ),
                                    const Text("700 sq ft"),
                                  ],
                                ));
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          // const Center(
          //   child: Text('data'),
          // )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
