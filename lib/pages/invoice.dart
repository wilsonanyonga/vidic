import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vidic/bloc/vidic_admin_bloc.dart';
import 'package:vidic/utils/dio_client.dart';
import 'package:vidic/widgets/menu_bar.dart';
import 'package:vidic/widgets/navigation_rail.dart';

class InvoiceScreen extends StatelessWidget {
  InvoiceScreen({Key? key}) : super(key: key);

  int _selectedIndex = 2;
  var mediaQsize, mediaQheight, mediaQwidth;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _controllerAmount = TextEditingController();
  final TextEditingController _controllerPurpose = TextEditingController();
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "January", child: Text("January")),
      const DropdownMenuItem(value: "February", child: Text("February")),
      const DropdownMenuItem(value: "March", child: Text("March")),
      const DropdownMenuItem(value: "April", child: Text("April")),
      const DropdownMenuItem(value: "May", child: Text("May")),
      const DropdownMenuItem(value: "June", child: Text("June")),
      const DropdownMenuItem(value: "July", child: Text("July")),
      const DropdownMenuItem(value: "August", child: Text("August")),
      const DropdownMenuItem(value: "September", child: Text("September")),
      const DropdownMenuItem(value: "October", child: Text("October")),
      const DropdownMenuItem(value: "November", child: Text("November")),
      const DropdownMenuItem(value: "December", child: Text("December")),
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    mediaQsize = MediaQuery.of(context).size;
    mediaQheight = mediaQsize.height;
    mediaQwidth = mediaQsize.width;

    String? selectedValue;
    String? selectedTenant;

    return BlocProvider(
      create: (context) => VidicAdminBloc(
        RepositoryProvider.of<DioClient>(context),
      )..add(InvoiceGetEvent()),
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
                // TODO: implement listener
                if (state is DeleteInvoiceSuccessState) {
                  AwesomeDialog(
                    context: context,
                    width: 600,
                    animType: AnimType.leftSlide,
                    headerAnimationLoop: false,
                    dismissOnBackKeyPress: false,
                    dialogType: DialogType.success,
                    showCloseIcon: true,
                    title: 'Invoice Deleted Successfully',
                    btnOkText: "OK",
                    btnOkOnPress: () {
                      BlocProvider.of<VidicAdminBloc>(context)
                          .add(InvoiceGetEvent());
                    },
                    btnOkIcon: Icons.check_circle,
                    onDismissCallback: (type) {
                      debugPrint('Dialog Dissmiss from callback $type');
                    },
                  ).show();
                }
                if (state is DeleteInvoiceRequestState) {
                  AwesomeDialog(
                    width: 600,
                    context: context,
                    dismissOnBackKeyPress: false,
                    dialogType: DialogType.question,
                    animType: AnimType.rightSlide,
                    title: 'Delete Letter',
                    desc: 'Are you sure you want to delete the letter',
                    btnCancelOnPress: () {
                      BlocProvider.of<VidicAdminBloc>(context)
                          .add(InvoiceGetEvent());
                    },
                    btnOkOnPress: () {
                      BlocProvider.of<VidicAdminBloc>(context)
                          .add(DeleteInvoiceEvent());
                    },
                  ).show();
                }
                if (state is UpdateInvoiceBackOption) {
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
                          .add(InvoiceGetEvent());
                      _controllerAmount.text = '';
                      _controllerPurpose.text = '';
                      selectedTenant = null;
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
                if (state is InvoiceBackOption) {
                  AwesomeDialog(
                    context: context,
                    width: 600,
                    animType: AnimType.leftSlide,
                    headerAnimationLoop: false,
                    dismissOnBackKeyPress: false,
                    dialogType: DialogType.success,
                    showCloseIcon: true,
                    title: 'Invoice Successfully Stored',
                    desc:
                        'You can choose to either go back home or add a new Invoice',
                    btnCancelText: "Back Home",
                    btnOkText: "Add Another Invoice",
                    btnOkOnPress: () {
                      // debugPrint('OnClcik');
                      BlocProvider.of<VidicAdminBloc>(context)
                          .add(CreateInvoiceEvent());
                      _controllerAmount.text = '';
                      _controllerPurpose.text = '';
                      selectedValue = null;
                      selectedTenant = null;
                    },
                    btnOkIcon: Icons.check_circle,
                    btnCancelOnPress: () {
                      BlocProvider.of<VidicAdminBloc>(context)
                          .add(InvoiceGetEvent());
                      _controllerAmount.text = '';
                      _controllerPurpose.text = '';
                      selectedValue = null;
                      selectedTenant = null;
                    },
                    onDismissCallback: (type) {
                      debugPrint('Dialog Dissmiss from callback $type');
                    },
                  ).show();
                }
              },
              builder: (context, state) {
                if (state is DeleteInvoiceSuccessLoadingState) {
                  return Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Deleting Invoice',
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
                if (state is UpdateInvoicesState) {
                  _controllerAmount.text = state.amount!;
                  _controllerPurpose.text = state.purpose!;
                  selectedValue = state.invoiceMonth;
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
                          'Update Invoice',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 400,
                          child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextFormField(
                                    controller: _controllerAmount,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      hintText: 'Enter Amount on Invoice (Ksh)',
                                      border: UnderlineInputBorder(),
                                      labelText:
                                          'Enter Amount on Invoice (Ksh)',
                                    ),
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the Amount on Invoice (Ksh)';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: _controllerPurpose,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      hintText: 'Enter Purpose of Invoice',
                                      border: UnderlineInputBorder(),
                                      labelText: 'Enter Purpose of Invoice',
                                    ),
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the Purpose of Invoice';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  DropdownButtonFormField(
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'Choose Month',
                                    ),
                                    items: dropdownItems,
                                    value: selectedValue,
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the Month';
                                      }
                                      return null;
                                    },
                                    onChanged: ((String? newValue) {
                                      selectedValue = newValue!;
                                      BlocProvider.of<VidicAdminBloc>(context)
                                          .add(UpdateInvoiceMonthEvent(
                                        tenantInvoiceMonth: selectedValue,
                                        amount: _controllerAmount.text,
                                        purpose: _controllerPurpose.text,
                                        uploadName: state.letterUpdateFileName,
                                      ));
                                      if (kDebugMode) {
                                        print("$selectedValue is select");
                                      }
                                    }),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    state.letterUpdateFileName,
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
                                          .add(UploadInvoiceUpdateFileEvent(
                                        amount: _controllerAmount.text,
                                        purpose: _controllerPurpose.text,
                                      ));
                                    },
                                    child: const Text('Upload Invoice'),
                                  ),
                                  const SizedBox(
                                    height: 10,
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
                                                UpdateInvoicePatchSendEvent(
                                                  amount:
                                                      _controllerAmount.text,
                                                  purpose:
                                                      _controllerPurpose.text,
                                                ),
                                              );
                                            }
                                          },
                                          child: Row(
                                            children: const [
                                              Text('Update Invoice'),
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
                                          label: const Text(
                                              'Creating New Invoice'),
                                        ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              )),
                        ),
                      ],
                    )),
                  );
                }
                if (state is CreateInvoiceState) {
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
                          'Create A New Invoice',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
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
                                    value: selectedTenant,
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the Tenant';
                                      }
                                      return null;
                                    },
                                    onChanged: ((String? newValue) {
                                      selectedTenant = newValue!;
                                      BlocProvider.of<VidicAdminBloc>(context)
                                          .add(SetTenantInvoiceIdEvent(
                                        tenantInvoiceId: selectedTenant,
                                      ));
                                      if (kDebugMode) {
                                        print("$selectedTenant is select");
                                      }
                                    }),
                                  ),
                                  TextFormField(
                                    controller: _controllerAmount,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      hintText: 'Enter Amount on Invoice (Ksh)',
                                      border: UnderlineInputBorder(),
                                      labelText:
                                          'Enter Amount on Invoice (Ksh)',
                                    ),
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the Amount on Invoice (Ksh)';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: _controllerPurpose,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      hintText: 'Enter Purpose of Invoice',
                                      border: UnderlineInputBorder(),
                                      labelText: 'Enter Purpose of Invoice',
                                    ),
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the Purpose of Invoice';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  DropdownButtonFormField(
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'Choose Month',
                                    ),
                                    items: dropdownItems,
                                    value: selectedValue,
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the Month';
                                      }
                                      return null;
                                    },
                                    onChanged: ((String? newValue) {
                                      selectedValue = newValue!;
                                      BlocProvider.of<VidicAdminBloc>(context)
                                          .add(SetTenantInvoiceMonthEvent(
                                              tenantInvoiceMonth:
                                                  selectedValue));
                                      if (kDebugMode) {
                                        print("$selectedValue is select");
                                      }
                                    }),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    state.invoiceFileName,
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
                                          .add(UploadInvoiceFileEvent());
                                    },
                                    child: const Text('Upload Invoice'),
                                  ),
                                  const SizedBox(
                                    height: 10,
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
                                                UploadTenantInvoiceEvent(
                                                  amount:
                                                      _controllerAmount.text,
                                                  purpose:
                                                      _controllerPurpose.text,
                                                ),
                                              );
                                            }
                                          },
                                          child: Row(
                                            children: const [
                                              Text('Create New Invoice'),
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
                                          label: const Text(
                                              'Creating New Invoice'),
                                          // child: Row(
                                          //   children: const [
                                          //     Text('Creating New Statement'),
                                          //     SizedBox(
                                          //       width: 10,
                                          //     ),
                                          //     SizedBox(
                                          //       width: 15,
                                          //       height: 15,
                                          //       child:
                                          //           CircularProgressIndicator(
                                          //         color: Colors.white,
                                          //         strokeWidth: 2,
                                          //       ),
                                          //     )
                                          //   ],
                                          // ),
                                        ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              )),
                        ),
                      ],
                    )),
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
                              'Invoice',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: SizedBox(
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
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          BlocConsumer<VidicAdminBloc, VidicAdminState>(
                            listener: (context, state) {
                              // TODO: implement listener
                            },
                            builder: (context, state) {
                              if (state is InvoiceLoading) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              if (state is InvoiceLoaded) {
                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: state.data.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Column(
                                      children: [
                                        ListTile(
                                          // leading: const Icon(Icons.person),
                                          // trailing: const Text(
                                          //   "GFG",
                                          //   style: TextStyle(
                                          //       color: Colors.green, fontSize: 15),
                                          // ),
                                          title: Row(
                                            children: [
                                              Text(state.data[index].name),
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
                                              // const SizedBox(
                                              //   width: 50,
                                              // ),
                                              // const Text("18/5/2021"),
                                              const SizedBox(
                                                width: 50,
                                              ),
                                              // Text(
                                              //     "Ksh ${state.data[index].rent}"),
                                            ],
                                          ),
                                        ),
                                        // for (var i = 0;
                                        //     i <
                                        //         state.data[index].invoiceTypes
                                        //             .length;
                                        //     i++)
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
                                                      'Purpose',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  DataColumn(
                                                    label: Text(
                                                      'Month',
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
                                                      i <
                                                          state
                                                              .data[index]
                                                              .invoiceTypes
                                                              .length;
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
                                                                UpdateInvoicesEvent(
                                                                  amount: state
                                                                      .data[
                                                                          index]
                                                                      .invoiceTypes[
                                                                          i]
                                                                      .amount
                                                                      .toString(),
                                                                  id: state
                                                                      .data[
                                                                          index]
                                                                      .invoiceTypes[
                                                                          i]
                                                                      .invoiceTypeId,
                                                                  invoiceMonth: state
                                                                      .data[
                                                                          index]
                                                                      .invoiceTypes[
                                                                          i]
                                                                      .month,
                                                                  purpose: state
                                                                      .data[
                                                                          index]
                                                                      .invoiceTypes[
                                                                          i]
                                                                      .purpose,
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                        DataCell(
                                                          Text(
                                                            state
                                                                .data[index]
                                                                .invoiceTypes[i]
                                                                .purpose,
                                                          ),
                                                        ),
                                                        DataCell(
                                                          Text(state
                                                              .data[index]
                                                              .invoiceTypes[i]
                                                              .month),
                                                        ),
                                                        DataCell(
                                                          Text(state
                                                              .data[index]
                                                              .invoiceTypes[i]
                                                              .amount
                                                              .toString()),
                                                        ),
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
                                                                DeleteInvoiceRequestEvent(
                                                                  id: state
                                                                      .data[
                                                                          index]
                                                                      .invoiceTypes[
                                                                          i]
                                                                      .invoiceTypeId,
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
                                        //           Text(
                                        //               "Purpose: ${state.data[index].invoiceTypes[i].purpose}"),
                                        //           const SizedBox(
                                        //             width: 20,
                                        //           ),
                                        //           Text(
                                        //               "Month: ${state.data[index].invoiceTypes[i].month}"),
                                        //           const SizedBox(
                                        //             width: 20,
                                        //           ),
                                        //           Text(
                                        //             "Amount: Ksh ${state.data[index].invoiceTypes[i].amount.toString()}",
                                        //           ),
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
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is UpdateInvoicesState) {
              return FloatingActionButton(
                  onPressed: () {
                    BlocProvider.of<VidicAdminBloc>(context)
                        .add(InvoiceGetEvent());
                  },
                  tooltip: 'Go Back',
                  child: const Icon(Icons.close));
            }
            if (state is CreateInvoiceState) {
              return FloatingActionButton(
                  onPressed: () {
                    BlocProvider.of<VidicAdminBloc>(context)
                        .add(InvoiceGetEvent());
                  },
                  tooltip: 'Go Back',
                  child: const Icon(Icons.close));
            }
            if (state is InvoiceLoading) {
              return const FloatingActionButton(
                onPressed: null,
                tooltip: 'Loading',
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }
            if (state is InvoiceLoaded) {
              return FloatingActionButton(
                onPressed: () {
                  BlocProvider.of<VidicAdminBloc>(context)
                      .add(CreateInvoiceEvent());
                },
                tooltip: 'Add New Invoice',
                child: const Icon(Icons.add),
              );
            }
            return const FloatingActionButton(
              onPressed: null,
              tooltip: 'Increment',
              child: Icon(Icons.add),
            );
          },
        ),
      ),
    );
  }
}
