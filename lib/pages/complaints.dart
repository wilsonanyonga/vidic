import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vidic/bloc/vidic_admin_bloc.dart';
import 'package:vidic/models/tenant_letter/get_tenant_letter3.dart';
import 'package:vidic/utils/dio_client.dart';
import 'package:vidic/widgets/menu_bar.dart';
import 'package:vidic/widgets/navigation_rail.dart';

import 'dart:js' as js;

// ignore: must_be_immutable
class ComplaintsScreen extends StatelessWidget {
  ComplaintsScreen({Key? key}) : super(key: key);

  final int _selectedIndex = 5;
  var mediaQsize, mediaQheight, mediaQwidth;

  @override
  Widget build(BuildContext context) {
    mediaQsize = MediaQuery.of(context).size;
    mediaQheight = mediaQsize.height;
    mediaQwidth = mediaQsize.width;

    return BlocProvider(
      create: (context) => VidicAdminBloc(
        RepositoryProvider.of<DioClient>(context),
      )..add(ComplaintGetEvent()),
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
                alignment: Alignment.topRight,
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
                          'Letters From Tenant',
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
                          if (state is ComplaintLoaded) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                              child: SizedBox(
                                height: 40,
                                width: 250,
                                child: TextField(
                                  onChanged: (value) {
                                    BlocProvider.of<VidicAdminBloc>(context)
                                        .add(ComplaintSearchEvent(
                                            searchMe: value));
                                  },
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
                            );
                          }
                          return const Text('');
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      BlocConsumer<VidicAdminBloc, VidicAdminState>(
                        listener: (context, state) {
                          // ignore: todo
                          // TODO: implement listener
                        },
                        builder: (context, state) {
                          if (state is ComplaintLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          if (state is ComplaintLoadingFailed) {
                            return Center(
                              child: ElevatedButton(
                                  onPressed: () {
                                    BlocProvider.of<VidicAdminBloc>(context)
                                        .add(ComplaintGetEvent());
                                  },
                                  child: const Text('Network Error, Reload')),
                            );
                          }
                          if (state is ComplaintLoaded) {
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                List<LettersTenantType> letterTenantList =
                                    state.data[index].lettersTenantTypes;
                                letterTenantList.sort((a, b) {
                                  return b.lettersTenantTypeId
                                      .compareTo(a.lettersTenantTypeId);
                                });
                                return Column(
                                  children: [
                                    ListTile(
                                      leading: const Icon(Icons.person),
                                      // trailing: const Text(
                                      //   "GFG",
                                      //   style: TextStyle(
                                      //       color: Colors.green, fontSize: 15),
                                      // ),
                                      title: ScrollConfiguration(
                                        behavior:
                                            ScrollConfiguration.of(context)
                                                .copyWith(
                                          dragDevices: {
                                            PointerDeviceKind.touch,
                                            PointerDeviceKind.mouse,
                                          },
                                        ),
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: [
                                              Text(
                                                state.data[index].name,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 50,
                                              ),
                                              // Text(state.data[index].officialEmail),
                                              // const SizedBox(
                                              //   width: 50,
                                              // ),
                                              Chip(
                                                label: (state.data[index]
                                                            .floor ==
                                                        "0")
                                                    ? const Text(
                                                        'Ground Floor',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      )
                                                    : (state.data[index]
                                                                .floor ==
                                                            "1")
                                                        ? const Text(
                                                            '1st Floor',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          )
                                                        : (state.data[index]
                                                                    .floor ==
                                                                "2")
                                                            ? const Text(
                                                                '2nd Floor',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              )
                                                            : (state.data[index]
                                                                        .floor ==
                                                                    "3")
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
                                                backgroundColor:
                                                    Colors.pink[300],
                                              ),
                                              // Chip(
                                              //   label: Text(
                                              //     '${state.data[index].floor} Floor',
                                              //     style: const TextStyle(
                                              //         color: Colors.white),
                                              //   ),
                                              //   backgroundColor: Colors.pink[300],
                                              // ),
                                              // const SizedBox(
                                              //   width: 50,
                                              // ),
                                              // Text("${state.data[index].size} sq ft"),
                                              // // const SizedBox(
                                              // //   width: 50,
                                              // // ),
                                              // // const Text("18/5/2021"),
                                              // const SizedBox(
                                              //   width: 50,
                                              // ),
                                              // Text("Ksh ${state.data[index].rent}"),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),

                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: ScrollConfiguration(
                                        behavior:
                                            ScrollConfiguration.of(context)
                                                .copyWith(
                                          dragDevices: {
                                            PointerDeviceKind.touch,
                                            PointerDeviceKind.mouse,
                                          },
                                        ),
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: DataTable(
                                            columns: const [
                                              DataColumn(
                                                label: Text(
                                                  'Subject',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              DataColumn(
                                                label: Text(
                                                  'Date',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              // DataColumn(
                                              //   label: Text(
                                              //     'Download',
                                              //     style: TextStyle(
                                              //         fontSize: 14,
                                              //         fontWeight:
                                              //             FontWeight.bold),
                                              //   ),
                                              // ),
                                              DataColumn(
                                                label: Text(
                                                  'View',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                            rows: [
                                              // for (var i = 0;
                                              //     i <
                                              //         state
                                              //             .data[index]
                                              //             .lettersTenantTypes
                                              //             .length;
                                              //     i++)
                                              for (var i = 0;
                                                  i < letterTenantList.length;
                                                  i++)
                                                DataRow(
                                                  cells: [
                                                    DataCell(
                                                      Text(
                                                        letterTenantList[i]
                                                            .subject
                                                            .toString(),
                                                      ),
                                                    ),
                                                    DataCell(
                                                      Text(letterTenantList[i]
                                                          .date
                                                          .toLocal()
                                                          .toString()
                                                          .substring(0, 10)),
                                                    ),
                                                    // DataCell(
                                                    //   IconButton(
                                                    //     icon: const Icon(
                                                    //         Icons.download),
                                                    //     tooltip:
                                                    //         'Download Letter',
                                                    //     onPressed: () {
                                                    //       // BlocProvider.of<
                                                    //       //             VidicAdminBloc>(
                                                    //       //         context)
                                                    //       //     .add(
                                                    //       //   UpdateOccupancyEvent(
                                                    //       //     floorId: state
                                                    //       //         .data[i].datumId,
                                                    //       //     occupancy: state
                                                    //       //         .data[i].occupancy
                                                    //       //         .toString(),
                                                    //       //     capacity: state
                                                    //       //         .data[i].capacity
                                                    //       //         .toString(),
                                                    //       //   ),
                                                    //       // );
                                                    //     },
                                                    //   ),
                                                    // ),
                                                    DataCell(
                                                      IconButton(
                                                        icon: const Icon(Icons
                                                            .remove_red_eye),
                                                        tooltip: 'View Letter',
                                                        onPressed: () {
                                                          js.context.callMethod(
                                                              'open', [
                                                            (letterTenantList[i]
                                                                .letterName)
                                                          ]);
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    // ListTile(
                                    //   title: Row(
                                    //     children: [
                                    //       Text(
                                    //         state.data[index]
                                    //             .lettersTenantTypes[i].subject
                                    //             .toString(),
                                    //       ),
                                    //       const SizedBox(
                                    //         width: 50,
                                    //       ),
                                    //       Text(
                                    //         "Date: ${state.data[index].lettersTenantTypes[i].date.toString().replaceAll('21:00:00.000Z', '')}",
                                    //       ),
                                    //       const SizedBox(
                                    //         width: 50,
                                    //       ),
                                    //       const Icon(Icons.delete)
                                    //     ],
                                    //   ),
                                    // ),
                                  ],
                                );
                              },
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
