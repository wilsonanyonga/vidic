import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vidic/bloc/vidic_admin_bloc.dart';
import 'package:vidic/utils/dio_client.dart';
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

    return BlocProvider(
      create: (context) => VidicAdminBloc(
        RepositoryProvider.of<DioClient>(context),
      )..add(OccupancyGetEvent()),
      child: Scaffold(
        body: Row(
          children: [
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraint) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraint.maxHeight),
                    child: IntrinsicHeight(
                      child:
                          WidgetNavigationRail(selectedIndex: _selectedIndex),
                    ),
                  ),
                );
              },
              // child:
            ),
            const VerticalDivider(thickness: 1, width: 2),
            Expanded(
              child: Align(
                alignment: Alignment.topLeft,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const MenuBarWidget(),
                      const SizedBox(
                        height: 20,
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Text(
                          'Occupancy',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      BlocConsumer<VidicAdminBloc, VidicAdminState>(
                        listener: (context, state) {
                          // TODO: implement listener
                        },
                        builder: (context, state) {
                          if (state is OccupancyLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          // shrinkWrap: true,
                          //     physics: const NeverScrollableScrollPhysics(),
                          if (state is OccupancyLoaded) {
                            return Column(
                              children: [
                                DataTable(
                                  columns: const [
                                    DataColumn(
                                      label: Text(
                                        'Edit',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Floor',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Occupancy',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                  rows: [
                                    for (var i = 0; i < state.data.length; i++)
                                      DataRow(
                                        cells: [
                                          const DataCell(Icon(Icons.edit)),
                                          DataCell(
                                            Chip(
                                              label: (state.data[i].floor == 0)
                                                  ? const Text(
                                                      'Ground Floor',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    )
                                                  : (state.data[i].floor == 1)
                                                      ? const Text(
                                                          '1st Floor',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        )
                                                      : (state.data[i].floor ==
                                                              2)
                                                          ? const Text(
                                                              '2nd Floor',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            )
                                                          : (state.data[i]
                                                                      .floor ==
                                                                  3)
                                                              ? const Text(
                                                                  '3rd Floor',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                )
                                                              : const Text(
                                                                  '4th Floor',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                              backgroundColor: Colors.pink[300],
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              "${state.data[i].occupancy.toString()} / ${state.data[i].capacity.toString()} Occupied",
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                                // ListTile(
                                //   leading: const Icon(Icons.edit),
                                //   // trailing: const Text(
                                //   //   "GFG",
                                //   //   style: TextStyle(
                                //   //       color: Colors.green, fontSize: 15),
                                //   // ),
                                //   title: Row(
                                //     children: [
                                //       Chip(
                                //         label: (state.data[index].floor == 0)
                                //             ? const Text(
                                //                 'Ground Floor',
                                //                 style: TextStyle(
                                //                     color: Colors.white),
                                //               )
                                //             : (state.data[index].floor == 1)
                                //                 ? const Text(
                                //                     '1st Floor',
                                //                     style: TextStyle(
                                //                         color: Colors.white),
                                //                   )
                                //                 : (state.data[index].floor == 2)
                                //                     ? const Text(
                                //                         '2nd Floor',
                                //                         style: TextStyle(
                                //                             color:
                                //                                 Colors.white),
                                //                       )
                                //                     : (state.data[index]
                                //                                 .floor ==
                                //                             3)
                                //                         ? const Text(
                                //                             '3rd Floor',
                                //                             style: TextStyle(
                                //                                 color: Colors
                                //                                     .white),
                                //                           )
                                //                         : const Text(
                                //                             '4th Floor',
                                //                             style: TextStyle(
                                //                                 color: Colors
                                //                                     .white),
                                //                           ),
                                //         backgroundColor: Colors.pink[300],
                                //       ),
                                //       // Text("${state.data[index].floor.toString()} Floor"),
                                //       const SizedBox(
                                //         width: 50,
                                //       ),
                                //       Text(
                                //         "${state.data[index].occupancy.toString()} / ${state.data[index].capacity.toString()} Occupied",
                                //       ),
                                //       const SizedBox(
                                //         width: 50,
                                //       ),
                                //       // Chip(
                                //       //   label: Text(
                                //       //     '${state.data[index].floor} Floor',
                                //       //     style: const TextStyle(
                                //       //         color: Colors.white),
                                //       //   ),
                                //       //   backgroundColor: Colors.pink[300],
                                //       // ),
                                //       const SizedBox(
                                //         width: 50,
                                //       ),
                                //       // Text("${state.data[index].size} sq ft"),
                                //       // const SizedBox(
                                //       //   width: 50,
                                //       // ),
                                //       // const Text("18/5/2021"),
                                //       const SizedBox(
                                //         width: 50,
                                //       ),
                                //       // Text("Ksh ${state.data[index].rent}"),
                                //     ],
                                //   ),
                                // ),

                                // for (var i = 0;
                                //     i < state.data[index].invoiceTypes.length;
                                //     i++)
                                //   Text(state
                                //       .data[index].invoiceTypes[i].amount
                                //       .toString()),
                              ],
                            );
                          }
                          return const Text('Error Occured');
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
