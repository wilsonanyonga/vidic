import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vidic/bloc/vidic_admin_bloc.dart';
// import 'package:vidic/models/occupancy/get_occupancy.dart';
import 'package:vidic/utils/dio_client.dart';
import 'package:vidic/widgets/menu_bar.dart';
import 'package:vidic/widgets/navigation_rail.dart';

class OccupancyScreen extends StatelessWidget {
  OccupancyScreen({Key? key}) : super(key: key);

  final int _selectedIndex = 4;
  var mediaQsize, mediaQheight, mediaQwidth;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _controllerOccupancy = TextEditingController();
  final TextEditingController _controllerCapacity = TextEditingController();

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
            BlocConsumer<VidicAdminBloc, VidicAdminState>(
              listener: (context, state) {
                // ignore: todo
                // TODO: implement listener
                if (state is OccupancyBackOption) {
                  AwesomeDialog(
                    context: context,
                    width: 600,
                    animType: AnimType.leftSlide,
                    headerAnimationLoop: false,
                    dismissOnBackKeyPress: false,
                    dialogType: DialogType.success,
                    showCloseIcon: true,
                    title: 'Occupancy Updated Successfully',
                    // desc:
                    //     'You can choose to either go back home or add a new Invoice',
                    // btnCancelText: "Back Home",
                    btnOkText: "OK",
                    btnOkOnPress: () {
                      // debugPrint('OnClcik');
                      BlocProvider.of<VidicAdminBloc>(context)
                          .add(OccupancyGetEvent());
                      // _controllerAmount.text = '';
                      // _controllerPurpose.text = '';
                      // selectedValue = null;
                      // selectedTenant = null;
                    },
                    btnOkIcon: Icons.check_circle,
                    // btnCancelOnPress: () {
                    //   BlocProvider.of<VidicAdminBloc>(context)
                    //       .add(InvoiceGetEvent());
                    //   // _controllerAmount.text = '';
                    //   // _controllerPurpose.text = '';
                    //   // selectedValue = null;
                    //   // selectedTenant = null;
                    // },
                    onDismissCallback: (type) {
                      debugPrint('Dialog Dissmiss from callback $type');
                    },
                  ).show();
                }
              },
              builder: (context, state) {
                if (state is UpdateOccupancyState) {
                  _controllerOccupancy.text = state.occupancy;
                  _controllerCapacity.text = state.capacity;
                  return Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          const Text(
                            'Update Building Occupancy',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: 400,
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextFormField(
                                    controller: _controllerOccupancy,
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                      hintText:
                                          'Enter Number Of Spaces Occupied',
                                      border: UnderlineInputBorder(),
                                      labelText:
                                          'Enter Number Of Spaces Occupied',
                                    ),
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please Enter Number Of Spaces Occupied';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: _controllerCapacity,
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                      hintText: 'Enter Capacity Of Building',
                                      border: UnderlineInputBorder(),
                                      labelText: 'Enter Capacity Of Building',
                                    ),
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please Enter Capacity Of Building';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  (state.loadingButton == 0)
                                      ? ElevatedButton(
                                          onPressed: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              // Process data. millicent.odhiambo@vidic.co.ke
                                              // signInWithEmailAndPassword();
                                              if (kDebugMode) {
                                                print('sending');
                                              }
                                              BlocProvider.of<VidicAdminBloc>(
                                                      context)
                                                  .add(
                                                UpdateOccupancyPatchEvent(
                                                  capacity:
                                                      _controllerCapacity.text,
                                                  floorId: state.floorId,
                                                  occupancy:
                                                      _controllerOccupancy.text,
                                                ),
                                              );
                                            }
                                          },
                                          child: Row(
                                            children: const [
                                              Text('Update Occupancy'),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              // SizedBox(
                                              //   width: 15,
                                              //   height: 15,
                                              //   child: CircularProgressIndicator(
                                              //     color: Colors.white,
                                              //     strokeWidth: 2,
                                              //   ),
                                              // )
                                            ],
                                          ),
                                        )
                                      : ElevatedButton.icon(
                                          icon: const CircularProgressIndicator(
                                            // color: Colors.white,
                                            strokeWidth: 2,
                                          ),
                                          onPressed: null,
                                          label:
                                              const Text('Updating Ocupancy'),
                                        ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return Expanded(
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
                              // ignore: todo
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
                                        for (var i = 0;
                                            i < state.data.length;
                                            i++)
                                          DataRow(
                                            cells: [
                                              DataCell(
                                                IconButton(
                                                  icon: const Icon(Icons.edit),
                                                  tooltip: 'Update Occupancy',
                                                  onPressed: () {
                                                    BlocProvider.of<
                                                                VidicAdminBloc>(
                                                            context)
                                                        .add(
                                                      UpdateOccupancyEvent(
                                                        floorId: state
                                                            .data[i].datumId,
                                                        occupancy: state
                                                            .data[i].occupancy
                                                            .toString(),
                                                        capacity: state
                                                            .data[i].capacity
                                                            .toString(),
                                                      ),
                                                    );
                                                  },
                                                ),
                                                // GestureDetector(
                                                //   onTap: () {
                                                //     BlocProvider.of<
                                                //                 VidicAdminBloc>(
                                                //             context)
                                                //         .add(
                                                //             UpdateOccupancyEvent());
                                                //   },
                                                //   child: const Icon(Icons.edit),
                                                // ),
                                              ),
                                              DataCell(
                                                Chip(
                                                  label: (state.data[i].floor ==
                                                          0)
                                                      ? const Text(
                                                          'Ground Floor',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        )
                                                      : (state.data[i].floor ==
                                                              1)
                                                          ? const Text(
                                                              '1st Floor',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            )
                                                          : (state.data[i]
                                                                      .floor ==
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
                                                                          color:
                                                                              Colors.white),
                                                                    )
                                                                  : const Text(
                                                                      '4th Floor',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                  backgroundColor:
                                                      Colors.pink[300],
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
                );
              },
            ),
          ],
        ),
        floatingActionButton: BlocConsumer<VidicAdminBloc, VidicAdminState>(
          listener: (context, state) {
            // ignore: todo
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is UpdateOccupancyState) {
              return FloatingActionButton(
                onPressed: () {
                  BlocProvider.of<VidicAdminBloc>(context)
                      .add(OccupancyGetEvent());
                },
                tooltip: 'Go Back',
                child: const Icon(Icons.close),
              );
            }
            return const Text('');
          },
        ),
      ),
    );
  }
}
