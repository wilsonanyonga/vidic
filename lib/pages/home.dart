import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:vidic/widgets/card.dart';
import 'package:vidic/widgets/navigation_rail.dart';
// import 'package:percent_indicator/percent_indicator.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  int _counter = 0;
  int _selectedIndex = 1;

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
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 45,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Stack(
                            children: [
                              const Positioned(
                                right: 135,
                                top: 5,
                                child: CircleAvatar(
                                  radius: 15,
                                  foregroundImage:
                                      AssetImage('assets/icons/vidic.png'),
                                ),
                              ),
                              Positioned(
                                right: 10,
                                top: 1,
                                child: Row(
                                  children: const [
                                    Text(
                                      'Francis Otworo',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Icon(Icons.arrow_drop_down)
                                  ],
                                ),
                              ),
                              const Positioned(
                                right: 101,
                                top: 25,
                                child: Text(
                                  'Admin',
                                  style: TextStyle(fontSize: 10),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Wrap(
                              children: const [
                                NewWidgetCardHome(),
                                NewWidgetCardHome(),
                                NewWidgetCardHome(),
                                NewWidgetCardHome(),
                                NewWidgetCardHome(),
                              ],
                            ),
                            // NewWidgetCardHome(),
                            // NewWidgetCardHome(),
                            // NewWidgetCardHome(),
                            // NewWidgetCardHome(),
                            // NewWidgetCardHome(),
                          ],
                        )
                      ],
                    ),
                  ),
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
