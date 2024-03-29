import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:vidic/bloc/vidic_admin_bloc.dart';
import 'package:vidic/models/statement/get_statement_type.dart';
import 'package:vidic/utils/dio_client.dart';
import 'package:vidic/widgets/menu_bar.dart';
import 'package:vidic/widgets/navigation_rail.dart';

import 'dart:js' as js;

// ignore: must_be_immutable
class StatementScreen extends StatelessWidget {
  StatementScreen({Key? key}) : super(key: key);

  final int _selectedIndex = 1;
  var mediaQsize, mediaQheight, mediaQwidth;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _controllerAmount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    mediaQsize = MediaQuery.of(context).size;
    mediaQheight = mediaQsize.height;
    mediaQwidth = mediaQsize.width;

    String? selectedValue;

    return BlocProvider(
      create: (context) => VidicAdminBloc(
        RepositoryProvider.of<DioClient>(context),
      )..add(StatementGetEvent()),
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
                if (state is DeleteStatementSuccessState) {
                  AwesomeDialog(
                    context: context,
                    width: 600,
                    animType: AnimType.leftSlide,
                    headerAnimationLoop: false,
                    dismissOnBackKeyPress: false,
                    dialogType: DialogType.success,
                    showCloseIcon: true,
                    title: 'Statement Deleted Successfully',
                    btnOkText: "OK",
                    btnOkOnPress: () {
                      BlocProvider.of<VidicAdminBloc>(context)
                          .add(StatementGetEvent());
                    },
                    btnOkIcon: Icons.check_circle,
                    onDismissCallback: (type) {
                      debugPrint('Dialog Dissmiss from callback $type');
                    },
                  ).show();
                }
                if (state is DeleteStatementRequestState) {
                  AwesomeDialog(
                    width: 600,
                    context: context,
                    dismissOnBackKeyPress: false,
                    dialogType: DialogType.question,
                    animType: AnimType.rightSlide,
                    title: 'Delete Statement',
                    desc: 'Are you sure you want to delete the letter',
                    btnCancelOnPress: () {
                      BlocProvider.of<VidicAdminBloc>(context)
                          .add(StatementGetEvent());
                    },
                    btnOkOnPress: () {
                      BlocProvider.of<VidicAdminBloc>(context)
                          .add(DeleteStatementEvent());
                    },
                  ).show();
                }
                if (state is UpdateStatementBackOption) {
                  AwesomeDialog(
                    context: context,
                    width: 600,
                    animType: AnimType.leftSlide,
                    headerAnimationLoop: false,
                    dismissOnBackKeyPress: false,
                    dialogType: DialogType.success,
                    showCloseIcon: true,
                    title: 'Letter Updated Successfully',
                    // desc:
                    //     'You can choose to either go back home or add a new Invoice',
                    // btnCancelText: "Back Home",
                    btnOkText: "OK",
                    btnOkOnPress: () {
                      // debugPrint('OnClcik');
                      BlocProvider.of<VidicAdminBloc>(context)
                          .add(StatementGetEvent());
                      _controllerAmount.text = '';
                      // _controllerPurpose.text = '';
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
                if (state is StatementBackOption) {
                  AwesomeDialog(
                    context: context,
                    width: 600,
                    animType: AnimType.leftSlide,
                    headerAnimationLoop: false,
                    dismissOnBackKeyPress: false,
                    dialogType: DialogType.success,
                    showCloseIcon: true,
                    title: 'Data Successfully Stored',
                    desc:
                        'You can choose to either go back home or add a new tenant',
                    btnCancelText: "Back Home",
                    btnOkText: "Add Another Tenant",
                    btnOkOnPress: () {
                      // debugPrint('OnClcik');
                      BlocProvider.of<VidicAdminBloc>(context)
                          .add(CreateStatementEvent());
                      _controllerAmount.text = '';

                      selectedValue = null;
                    },
                    btnOkIcon: Icons.check_circle,
                    btnCancelOnPress: () {
                      BlocProvider.of<VidicAdminBloc>(context)
                          .add(StatementGetEvent());
                      _controllerAmount.text = '';
                      selectedValue = null;
                    },
                    onDismissCallback: (type) {
                      debugPrint('Dialog Dissmiss from callback $type');
                    },
                  ).show();
                }
              },
              builder: (context, state) {
                if (state is DeleteStatementSuccessLoadingState) {
                  return const Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Deleting Statement',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Kindly Wait',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                if (state is UpdateStatementsState) {
                  _controllerAmount.text = state.amount!;
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
                            'Update Statement',
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
                                  // DropdownButtonFormField(
                                  //   decoration: const InputDecoration(
                                  //     border: UnderlineInputBorder(),
                                  //     labelText: 'Choose Tenant',
                                  //   ),
                                  //   items: state.dropdownItems,
                                  //   value: selectedValue,
                                  //   validator: (String? value) {
                                  //     if (value == null || value.isEmpty) {
                                  //       return 'Please enter the Tenant';
                                  //     }
                                  //     return null;
                                  //   },
                                  //   onChanged: ((String? newValue) {
                                  //     selectedValue = newValue!;
                                  //     BlocProvider.of<VidicAdminBloc>(context)
                                  //         .add(CreateTenantStatementEvent(
                                  //       tenantStatementName: selectedValue,
                                  //     ));
                                  //     if (kDebugMode) {
                                  //       print("$selectedValue is select");
                                  //     }
                                  //   }),
                                  // ),
                                  TextFormField(
                                    controller: _controllerAmount,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      hintText: 'Enter Amount on Statement',
                                      border: UnderlineInputBorder(),
                                      labelText: 'Enter Amount on Statement',
                                    ),
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the Amount on Statement';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    state.statementUpdateFileName,
                                    style: const TextStyle(
                                      fontSize: 17,
                                    ),
                                  ),
                                  // (state.fileName != null)?
                                  // Text(state.fileName!):const Text(''),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      BlocProvider.of<VidicAdminBloc>(context)
                                          .add(
                                        UploadStatementUpdateFileEvent(
                                          amount: _controllerAmount.text,
                                        ),
                                      );
                                    },
                                    child: const Text('Upload Statement'),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const Text(
                                    'Statement Start Date',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                  SfDateRangePicker(
                                    initialDisplayDate: state.startDate,
                                    showNavigationArrow: true,
                                    initialSelectedDate: state.startDate,
                                    onSelectionChanged:
                                        (DateRangePickerSelectionChangedArgs
                                            args) {
                                      BlocProvider.of<VidicAdminBloc>(context)
                                          .add(
                                              CreateStatementUpdateStartDateEvent(
                                        statementStartDate: args.value,
                                        amount: _controllerAmount.text,
                                      ));
                                    },
                                    selectionMode:
                                        DateRangePickerSelectionMode.single,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const Text(
                                    'Statement End Date',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                  SfDateRangePicker(
                                    initialDisplayDate: state.endDate,
                                    showNavigationArrow: true,
                                    initialSelectedDate: state.endDate,
                                    onSelectionChanged: (
                                      DateRangePickerSelectionChangedArgs args,
                                    ) {
                                      BlocProvider.of<VidicAdminBloc>(context)
                                          .add(
                                        CreateStatementUpdateEndDateEvent(
                                          statementEndDate: args.value,
                                          amount: _controllerAmount.text,
                                        ),
                                      );
                                    },
                                    selectionMode:
                                        DateRangePickerSelectionMode.single,
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
                                                print(
                                                    'sending, ${_controllerAmount.text}');
                                              }
                                              BlocProvider.of<VidicAdminBloc>(
                                                      context)
                                                  .add(
                                                UpdateStatementPatchSendEvent(
                                                  amount:
                                                      _controllerAmount.text,
                                                ),
                                              );
                                            }
                                          },
                                          child: const Row(
                                            children: [
                                              Text('Update Statement'),
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
                                      : const ElevatedButton(
                                          onPressed: null,
                                          child: Row(
                                            children: [
                                              Text('Creating New Statement'),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              SizedBox(
                                                width: 15,
                                                height: 15,
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.white,
                                                  strokeWidth: 2,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }
                if (state is CreateStatementState) {
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
                            'Create A New Statement',
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
                                  DropdownButtonFormField(
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'Choose Tenant',
                                    ),
                                    items: state.dropdownItems,
                                    value: selectedValue,
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the Tenant';
                                      }
                                      return null;
                                    },
                                    onChanged: ((String? newValue) {
                                      selectedValue = newValue!;
                                      BlocProvider.of<VidicAdminBloc>(context)
                                          .add(CreateTenantStatementEvent(
                                        tenantStatementName: selectedValue,
                                      ));
                                      if (kDebugMode) {
                                        print("$selectedValue is select");
                                      }
                                    }),
                                  ),
                                  TextFormField(
                                    controller: _controllerAmount,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      hintText: 'Enter Amount on Statement',
                                      border: UnderlineInputBorder(),
                                      labelText: 'Enter Amount on Statement',
                                    ),
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the Amount on Statement';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    state.fileName!,
                                    style: const TextStyle(
                                      fontSize: 17,
                                    ),
                                  ),
                                  // (state.fileName != null)?
                                  // Text(state.fileName!):const Text(''),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      BlocProvider.of<VidicAdminBloc>(context)
                                          .add(UploadStatementFileEvent());
                                    },
                                    child: const Text('Upload Statement'),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const Text(
                                    'Statement Start Date',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                  SfDateRangePicker(
                                    onSelectionChanged:
                                        (DateRangePickerSelectionChangedArgs
                                            args) {
                                      BlocProvider.of<VidicAdminBloc>(context)
                                          .add(CreateStatementStartDateEvent(
                                              statementStartDate: args.value
                                                  .toString()
                                                  .replaceAll(
                                                      ' 00:00:00.000', '')));
                                    },
                                    selectionMode:
                                        DateRangePickerSelectionMode.single,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const Text(
                                    'Statement End Date',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                  SfDateRangePicker(
                                    onSelectionChanged:
                                        (DateRangePickerSelectionChangedArgs
                                            args) {
                                      BlocProvider.of<VidicAdminBloc>(context)
                                          .add(CreateStatementEndDateEvent(
                                              statementEndDate: args.value
                                                  .toString()
                                                  .replaceAll(
                                                      ' 00:00:00.000', '')));
                                    },
                                    selectionMode:
                                        DateRangePickerSelectionMode.single,
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
                                                UploadTenantStatementEvent(
                                                  amount:
                                                      _controllerAmount.text,
                                                ),
                                              );
                                            }
                                          },
                                          child: const Row(
                                            children: [
                                              Text('Create New Statement'),
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
                                      : const ElevatedButton(
                                          onPressed: null,
                                          child: Row(
                                            children: [
                                              Text('Creating New Statement'),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              SizedBox(
                                                width: 15,
                                                height: 15,
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.white,
                                                  strokeWidth: 2,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }
                return Expanded(
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
                              'Statements',
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
                              if (state is StatementLoaded) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  child: SizedBox(
                                    height: 40,
                                    width: 250,
                                    child: TextField(
                                      onChanged: (value) {
                                        BlocProvider.of<VidicAdminBloc>(context)
                                            .add(StatementSearchEvent(
                                                searchMe: value));
                                      },
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide.none,
                                          // borderSide: const BorderSide(
                                          //   color: Colors.green,
                                          //   width: 1.0,
                                          // ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
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
                                        floatingLabelStyle: const TextStyle(
                                            color: Colors.black),
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
                              if (state is StatementLoading) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }

                              if (state is StatementLoadingFailed) {
                                return Center(
                                  child: ElevatedButton(
                                      onPressed: () {
                                        BlocProvider.of<VidicAdminBloc>(context)
                                            .add(StatementGetEvent());
                                      },
                                      child:
                                          const Text('Network Error, Reload')),
                                );
                              }

                              if (state is StatementLoaded) {
                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: state.data.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    List<StatementType> statementList =
                                        state.data[index].statementTypes;
                                    statementList.sort((a, b) {
                                      return b.statementTypeId
                                          .compareTo(a.statementTypeId);
                                    });
                                    return Column(
                                      children: [
                                        ListTile(
                                          // leading: const Icon(Icons.person),
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
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  const SizedBox(
                                                    width: 50,
                                                  ),
                                                  // Text(state.data[index]
                                                  //     .officialEmail),
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
                                                                color: Colors
                                                                    .white),
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
                                                      'Edit',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  DataColumn(
                                                    label: Text(
                                                      'From',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  DataColumn(
                                                    label: Text(
                                                      'To',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  DataColumn(
                                                    label: Text(
                                                      'Amount',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  DataColumn(
                                                    label: Text(
                                                      'View',
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
                                                      'Delete',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ],
                                                rows: [
                                                  for (var i = 0;
                                                      i < statementList.length;
                                                      i++)
                                                    DataRow(
                                                      cells: [
                                                        DataCell(
                                                          IconButton(
                                                            icon: const Icon(
                                                                Icons.edit),
                                                            tooltip:
                                                                'Update Invoice',
                                                            onPressed: () {
                                                              BlocProvider.of<
                                                                          VidicAdminBloc>(
                                                                      context)
                                                                  .add(
                                                                UpdateStatementsEvent(
                                                                  id: statementList[
                                                                          i]
                                                                      .statementTypeId,
                                                                  amount: statementList[
                                                                          i]
                                                                      .amount
                                                                      .toString(),
                                                                  statementStartDate:
                                                                      statementList[
                                                                              i]
                                                                          .startDate,
                                                                  statementEndDate:
                                                                      statementList[
                                                                              i]
                                                                          .endDate,
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                        DataCell(
                                                          Text(state
                                                              .data[index]
                                                              .statementTypes[i]
                                                              .startDate
                                                              .toLocal()
                                                              .toString()
                                                              .substring(
                                                                  0, 10)),
                                                        ),
                                                        DataCell(
                                                          Text(state
                                                              .data[index]
                                                              .statementTypes[i]
                                                              .endDate
                                                              .toLocal()
                                                              .toString()
                                                              .substring(
                                                                  0, 10)),
                                                        ),
                                                        DataCell(
                                                          Text(
                                                            state
                                                                .data[index]
                                                                .statementTypes[
                                                                    i]
                                                                .amount
                                                                .toString(),
                                                          ),
                                                        ),
                                                        DataCell(
                                                          IconButton(
                                                            icon: const Icon(Icons
                                                                .remove_red_eye),
                                                            tooltip:
                                                                'View Letter',
                                                            onPressed: () {
                                                              js.context
                                                                  .callMethod(
                                                                      'open', [
                                                                (state
                                                                    .data[index]
                                                                    .statementTypes[
                                                                        i]
                                                                    .statementName)
                                                              ]);
                                                              // BlocProvider.of<
                                                              //             VidicAdminBloc>(
                                                              //         context)
                                                              //     .add(
                                                              //   UpdateOccupancyEvent(
                                                              //     floorId: state
                                                              //         .data[i].datumId,
                                                              //     occupancy: state
                                                              //         .data[i].occupancy
                                                              //         .toString(),
                                                              //     capacity: state
                                                              //         .data[i].capacity
                                                              //         .toString(),
                                                              //   ),
                                                              // );
                                                            },
                                                          ),
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
                                                                .delete_forever),
                                                            tooltip:
                                                                'Delete Letter',
                                                            onPressed: () {
                                                              BlocProvider.of<
                                                                          VidicAdminBloc>(
                                                                      context)
                                                                  .add(
                                                                DeleteStatementRequestEvent(
                                                                  id: statementList[
                                                                          i]
                                                                      .statementTypeId,
                                                                ),
                                                              );
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
                                        //   leading: const Icon(Icons.edit),
                                        //   title: ScrollConfiguration(
                                        //     behavior: ScrollConfiguration.of(
                                        //             context)
                                        //         .copyWith(
                                        //       dragDevices: {
                                        //         PointerDeviceKind.touch,
                                        //         PointerDeviceKind.mouse,
                                        //       },
                                        //     ),
                                        //     child: SingleChildScrollView(
                                        //       scrollDirection:
                                        //           Axis.horizontal,
                                        //       child: Row(
                                        //         children: [
                                        //           Text(state
                                        //               .data[index]
                                        //               .statementTypes[i]
                                        //               .startDate
                                        //               .toString()
                                        //               .replaceAll(
                                        //                   '21:00:00.000Z',
                                        //                   '')),
                                        //           const SizedBox(
                                        //             width: 20,
                                        //           ),
                                        //           const Text('--'),
                                        //           const SizedBox(
                                        //             width: 20,
                                        //           ),
                                        //           Text(state
                                        //               .data[index]
                                        //               .statementTypes[i]
                                        //               .endDate
                                        //               .toString()
                                        //               .replaceAll(
                                        //                   '21:00:00.000Z',
                                        //                   '')),
                                        //           const SizedBox(
                                        //             width: 50,
                                        //           ),
                                        //           Text(
                                        //               "Amount: Ksh ${state.data[index].statementTypes[i].amount.toString()}"),
                                        //           const SizedBox(
                                        //             width: 20,
                                        //           ),
                                        //           const Icon(Icons.delete),
                                        //         ],
                                        //       ),
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    );
                                  },
                                );
                              }
                              return const Text('Loading, Kindly Wait.');
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
            if (state is CreateStatementState) {
              return FloatingActionButton(
                  onPressed: () {
                    BlocProvider.of<VidicAdminBloc>(context)
                        .add(StatementGetEvent());
                    _controllerAmount.text = '';
                  },
                  tooltip: 'Go Back',
                  child: const Icon(Icons.close));
            }
            if (state is UpdateStatementsState) {
              return FloatingActionButton(
                  onPressed: () {
                    BlocProvider.of<VidicAdminBloc>(context)
                        .add(StatementGetEvent());
                    _controllerAmount.text = '';
                  },
                  tooltip: 'Go Back',
                  child: const Icon(Icons.close));
            }
            if (state is StatementLoading) {
              return const FloatingActionButton(
                onPressed: null,
                tooltip: 'Loading',
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }
            if (state is StatementLoaded) {
              return FloatingActionButton(
                onPressed: () {
                  BlocProvider.of<VidicAdminBloc>(context)
                      .add(CreateStatementEvent());
                },
                tooltip: 'Add New Statement',
                child: const Icon(Icons.add),
              );
            }
            return FloatingActionButton(
              onPressed: () {},
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            );
          },
        ),
      ),
    );
  }
}
