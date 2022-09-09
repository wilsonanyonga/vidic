import 'package:flutter/material.dart';
import 'package:vidic/widgets/menu_bar.dart';
import 'package:vidic/widgets/navigation_rail.dart';

class OccupancyScreen extends StatelessWidget {
  OccupancyScreen({Key? key}) : super(key: key);

  int _selectedIndex = 4;
  var mediaQsize, mediaQheight, mediaQwidth;

  @override
  Widget build(BuildContext context) {
    mediaQsize = MediaQuery.of(context).size;
    mediaQheight = mediaQsize.height;
    mediaQwidth = mediaQsize.width;

    return Scaffold(
      body: Row(
        children: [
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
          const VerticalDivider(thickness: 1, width: 2),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                MenuBarWidget(),
                SizedBox(
                  height: 20,
                ),
                Text('Occupancy'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
