import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:vidic/bloc/vidic_admin_bloc.dart';
import 'package:vidic/utils/auth.dart';
import 'package:vidic/utils/dio_client.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? errorMessage = '';
  // bool isLogin = true;

  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerNumber = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerAbout = TextEditingController();
  final TextEditingController _controllerFloor = TextEditingController();
  final TextEditingController _controllerSize = TextEditingController();
  final TextEditingController _controllerRent = TextEditingController();
  final TextEditingController _controllerEscalation = TextEditingController();
  final TextEditingController _controllerPoBox = TextEditingController();
  final TextEditingController _controllerLeaseStart = TextEditingController();
  final TextEditingController _controllerLeaseEnd = TextEditingController();

  // final List<String> floorList = <String>['0', '1', '2', '3', '4'];
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "0", child: Text("Ground Floor")),
      const DropdownMenuItem(value: "1", child: Text("1st Floor")),
      const DropdownMenuItem(value: "2", child: Text("2nd Floor")),
      const DropdownMenuItem(value: "3", child: Text("3rd Floor")),
      const DropdownMenuItem(value: "4", child: Text("4th Floor")),
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    mediaQsize = MediaQuery.of(context).size;
    mediaQheight = mediaQsize.height;
    mediaQwidth = mediaQsize.width;
    // String dropdownValue = floorList.first;
    // String selectedValue = "0";
    String? selectedValue;
    String? _selectedDate;

    // _controllerName.text = 'lol';
    // _controllerNumber.text = null;
    if (kDebugMode) {
      print('object is home');
    }
    Future<void> signOut() async {
      await Auth().signOut();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      //Return String
      String? stringValue = prefs.getString('email');
      if (kDebugMode) {
        print(stringValue);
      }
    }

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return BlocProvider(
      create: (context) => VidicAdminBloc(
        RepositoryProvider.of<DioClient>(context),
      )..add(TenantGetEvent()),
      child: Scaffold(
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

            // end of navigation rail

            const VerticalDivider(thickness: 1, width: 2),

            BlocConsumer<VidicAdminBloc, VidicAdminState>(
              listener: (context, state) {
                // TODO: implement listener
                if (state is DeleteTenantSuccessState) {
                  AwesomeDialog(
                    context: context,
                    width: 600,
                    animType: AnimType.leftSlide,
                    headerAnimationLoop: false,
                    dismissOnBackKeyPress: false,
                    dialogType: DialogType.success,
                    showCloseIcon: true,
                    title: 'Tenant Deleted Successfully',
                    btnOkText: "OK",
                    btnOkOnPress: () {
                      BlocProvider.of<VidicAdminBloc>(context)
                          .add(TenantGetEvent());
                    },
                    btnOkIcon: Icons.check_circle,
                    onDismissCallback: (type) {
                      debugPrint('Dialog Dissmiss from callback $type');
                    },
                  ).show();
                }
                if (state is DeleteTenantRequestState) {
                  AwesomeDialog(
                    width: 600,
                    context: context,
                    dismissOnBackKeyPress: false,
                    dialogType: DialogType.question,
                    animType: AnimType.rightSlide,
                    title: 'Delete Tenant',
                    desc: 'Are you sure you want to delete the letter',
                    btnCancelOnPress: () {
                      BlocProvider.of<VidicAdminBloc>(context)
                          .add(TenantGetEvent());
                    },
                    btnOkOnPress: () {
                      BlocProvider.of<VidicAdminBloc>(context)
                          .add(DeleteTenantEvent());
                    },
                  ).show();
                }
                if (state is UpdateTenantBackOption) {
                  AwesomeDialog(
                    context: context,
                    width: 600,
                    animType: AnimType.leftSlide,
                    headerAnimationLoop: false,
                    dismissOnBackKeyPress: false,
                    dialogType: DialogType.success,
                    showCloseIcon: true,
                    title: 'Tenant Updated Successfully',
                    // desc:
                    //     'You can choose to either go back home or add a new Invoice',
                    // btnCancelText: "Back Home",
                    btnOkText: "OK",
                    btnOkOnPress: () {
                      // debugPrint('OnClcik');
                      BlocProvider.of<VidicAdminBloc>(context)
                          .add(TenantGetEvent());
                      _controllerName.text = '';
                      _controllerNumber.text = '';
                      _controllerEmail.text = '';
                      _controllerAbout.text = '';
                      selectedValue = null;
                      _controllerSize.text = '';
                      _controllerRent.text = '';
                      _controllerEscalation.text = '';
                      _controllerPoBox.text = '';
                      _controllerLeaseStart.text = '';
                      _controllerLeaseEnd.text = '';
                      // _controllerAmount.text = '';
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
                if (state is TenantBackOption) {
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
                          .add(CreateTenantEvent());
                      _controllerName.text = '';
                      _controllerNumber.text = '';
                      _controllerEmail.text = '';
                      _controllerAbout.text = '';
                      selectedValue = null;
                      _controllerSize.text = '';
                      _controllerRent.text = '';
                      _controllerEscalation.text = '';
                      _controllerPoBox.text = '';
                      _controllerLeaseStart.text = '';
                      _controllerLeaseEnd.text = '';
                    },
                    btnOkIcon: Icons.check_circle,
                    btnCancelOnPress: () {
                      BlocProvider.of<VidicAdminBloc>(context)
                          .add(TenantGetEvent());
                      _controllerName.text = '';
                      _controllerNumber.text = '';
                      _controllerEmail.text = '';
                      _controllerAbout.text = '';
                      selectedValue = null;
                      _controllerSize.text = '';
                      _controllerRent.text = '';
                      _controllerEscalation.text = '';
                      _controllerPoBox.text = '';
                      _controllerLeaseStart.text = '';
                      _controllerLeaseEnd.text = '';
                    },
                    onDismissCallback: (type) {
                      debugPrint('Dialog Dissmiss from callback $type');
                    },
                  ).show();
                }
              },
              builder: (context, state) {
                if (state is DeleteTenantSuccessLoadingState) {
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
                            'Deleting Tenant',
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
                if (state is UpdateTenantState) {
                  _controllerName.text = state.name!;
                  _controllerNumber.text = state.number!;
                  _controllerEmail.text = state.officialEmail!;
                  _controllerAbout.text = state.about!;
                  selectedValue = state.floor;
                  _controllerSize.text = state.size!;
                  _controllerRent.text = state.rent!;
                  _controllerEscalation.text = state.escalation!;
                  _controllerPoBox.text = state.pobox!;
                  _controllerLeaseStart.text = state.leaseStartDate.toString();
                  _controllerLeaseEnd.text = state.leaseEndDate.toString();
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
                            'Update Tenant Details',
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
                                    controller: _controllerName,
                                    keyboardType: TextInputType.name,
                                    decoration: const InputDecoration(
                                      hintText: 'Enter Company Name',
                                      border: UnderlineInputBorder(),
                                      labelText: 'Enter Company Name',
                                    ),
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the Company Name';
                                      }
                                      return null;
                                    },
                                  ),
                                  TextFormField(
                                    controller: _controllerNumber,
                                    keyboardType: TextInputType.phone,
                                    decoration: const InputDecoration(
                                      // hintText: 'Enter Company Phone Number',
                                      border: UnderlineInputBorder(),
                                      labelText: 'Enter Company Phone Number',
                                    ),
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the Company Phone Number';
                                      }
                                      return null;
                                    },
                                  ),
                                  TextFormField(
                                    controller: _controllerEmail,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'Enter your email',
                                    ),
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter some text';
                                      } else if (value.contains('@') == false) {
                                        return 'Please enter a valid email';
                                      }
                                      return null;
                                    },
                                  ),
                                  TextFormField(
                                    controller: _controllerAbout,
                                    keyboardType: TextInputType.multiline,
                                    // expands: true,
                                    maxLines: null,
                                    decoration: const InputDecoration(
                                      // hintText: 'Enter Company Description',
                                      border: UnderlineInputBorder(),
                                      labelText: 'Enter Company Description',
                                    ),
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the Company Description';
                                      }
                                      return null;
                                    },
                                  ),
                                  DropdownButtonFormField(
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'Choose Floor',
                                    ),
                                    items: dropdownItems,
                                    value: selectedValue,
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the Floor';
                                      }
                                      return null;
                                    },
                                    onChanged: ((String? newValue) {
                                      selectedValue = newValue!;
                                      BlocProvider.of<VidicAdminBloc>(context)
                                          .add(UpdateTenantFloorEvent(
                                        floor: selectedValue,
                                        about: _controllerAbout.text,
                                        escalation: _controllerEscalation.text,
                                        name: _controllerName.text,
                                        number: _controllerNumber.text,
                                        officialEmail: _controllerEmail.text,
                                        pobox: _controllerPoBox.text,
                                        rent: _controllerRent.text,
                                        size: _controllerSize.text,
                                      ));
                                      if (kDebugMode) {
                                        print("$selectedValue is select");
                                      }
                                    }),
                                  ),
                                  // TextFormField(
                                  //   controller: _controllerFloor,
                                  //   keyboardType: TextInputType.number,
                                  //   decoration: const InputDecoration(
                                  //     border: UnderlineInputBorder(),
                                  //     labelText: 'Enter Floor',
                                  //   ),
                                  //   validator: (String? value) {
                                  //     if (value == null || value.isEmpty) {
                                  //       return 'Please enter the Floor';
                                  //     }
                                  //     return null;
                                  //   },
                                  // ),
                                  TextFormField(
                                    controller: _controllerSize,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'Enter Floor Size(sq ft)',
                                    ),
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the Floor Size';
                                      }
                                      return null;
                                    },
                                  ),
                                  TextFormField(
                                    controller: _controllerRent,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'Enter Rent Amount (Ksh)',
                                    ),
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the Rent Amount';
                                      }
                                      return null;
                                    },
                                  ),
                                  TextFormField(
                                    controller: _controllerEscalation,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'Enter Rent Escalation (%)',
                                    ),
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the Rent Escalation';
                                      }
                                      return null;
                                    },
                                  ),
                                  TextFormField(
                                    controller: _controllerPoBox,
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'Enter P.O.Box',
                                    ),
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the P.O.Box';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const Text(
                                    'Lease Start Date',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                  SfDateRangePicker(
                                    initialDisplayDate: state.leaseStartDate,
                                    showNavigationArrow: true,
                                    initialSelectedDate: state.leaseStartDate,
                                    onSelectionChanged:
                                        (DateRangePickerSelectionChangedArgs
                                            args) {
                                      BlocProvider.of<VidicAdminBloc>(context)
                                          .add(
                                        UpdateTenantLeaseStartEvent(
                                          leaseStart: args.value,
                                          about: _controllerAbout.text,
                                          escalation:
                                              _controllerEscalation.text,
                                          name: _controllerName.text,
                                          number: _controllerNumber.text,
                                          officialEmail: _controllerEmail.text,
                                          pobox: _controllerPoBox.text,
                                          rent: _controllerRent.text,
                                          size: _controllerSize.text,
                                        ),
                                      );
                                    },
                                    selectionMode:
                                        DateRangePickerSelectionMode.single,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const Text(
                                    'Lease End Date',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                  SfDateRangePicker(
                                    initialDisplayDate: state.leaseEndDate,
                                    showNavigationArrow: true,
                                    initialSelectedDate: state.leaseEndDate,
                                    onSelectionChanged:
                                        (DateRangePickerSelectionChangedArgs
                                            args) {
                                      BlocProvider.of<VidicAdminBloc>(context)
                                          .add(
                                        UpdateTenantLeaseEndEvent(
                                          leaseEnd: args.value,
                                          about: _controllerAbout.text,
                                          escalation:
                                              _controllerEscalation.text,
                                          name: _controllerName.text,
                                          number: _controllerNumber.text,
                                          officialEmail: _controllerEmail.text,
                                          pobox: _controllerPoBox.text,
                                          rent: _controllerRent.text,
                                          size: _controllerSize.text,
                                        ),
                                      );
                                    },
                                    selectionMode:
                                        DateRangePickerSelectionMode.single,
                                  ),
                                  // TextFormField(
                                  //   controller: _controllerLeaseStart,
                                  //   keyboardType: TextInputType.datetime,
                                  //   decoration: const InputDecoration(
                                  //     border: UnderlineInputBorder(),
                                  //     labelText:
                                  //         'Enter Lease Start Date (year-month-date) (2020-01-08)',
                                  //   ),
                                  //   validator: (String? value) {
                                  //     if (value == null || value.isEmpty) {
                                  //       return 'Please enter the Lease Start Date';
                                  //     }
                                  //     return null;
                                  //   },
                                  // ),
                                  // TextFormField(
                                  //   controller: _controllerLeaseEnd,
                                  //   keyboardType: TextInputType.datetime,
                                  //   decoration: const InputDecoration(
                                  //     border: UnderlineInputBorder(),
                                  //     labelText:
                                  //         'Enter Lease End Date (year-month-date) (2020-01-08)',
                                  //   ),
                                  //   validator: (String? value) {
                                  //     if (value == null || value.isEmpty) {
                                  //       return 'Please enter the Lease End Date';
                                  //     }
                                  //     return null;
                                  //   },
                                  // ),
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
                                                UpdateTenantDetailsEvent(
                                                  name: _controllerName.text,
                                                  number: _controllerNumber.text
                                                      .toString(),
                                                  officialEmail:
                                                      _controllerEmail.text,
                                                  about: _controllerAbout.text,
                                                  // floor: selectedValue,
                                                  size: _controllerSize.text
                                                      .toString(),
                                                  rent: _controllerRent.text
                                                      .toString(),
                                                  escalation:
                                                      _controllerEscalation.text
                                                          .toString(),
                                                  pobox: _controllerPoBox.text,
                                                  // leaseStartDate:
                                                  //     _controllerLeaseStart
                                                  //         .text,
                                                  // leaseEndDate:
                                                  //     _controllerLeaseEnd.text,
                                                  // active: '1',
                                                ),
                                              );
                                              // _controllerName.text = '';
                                              // _controllerNumber.text = '';
                                              // _controllerEmail.text = '';
                                              // _controllerAbout.text = '';
                                              // selectedValue = null;
                                              // _controllerSize.text = '';
                                              // _controllerRent.text = '';
                                              // _controllerEscalation.text = '';
                                              // _controllerPoBox.text = '';
                                              // _controllerLeaseStart.text = '';
                                              // _controllerLeaseEnd.text = '';
                                            }
                                          },
                                          child: Row(
                                            children: const [
                                              Text('Update Tenant'),
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
                                      : ElevatedButton(
                                          onPressed: null,
                                          child: Row(
                                            children: const [
                                              Text('Updating Tenant'),
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
                                    height: 30,
                                  ),
                                ],
                              ),
                            ),
                          )
                          // ElevatedButton(
                          //   onPressed: () {
                          //     BlocProvider.of<VidicAdminBloc>(context)
                          //         .add(TenantGetEvent());
                          //   },
                          //   child: const Text('back'),
                          // )
                        ],
                      ),
                    ),
                  );
                }
                if (state is CreateTenantState) {
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
                            'Create A New Tenant',
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
                                    controller: _controllerName,
                                    keyboardType: TextInputType.name,
                                    decoration: const InputDecoration(
                                      hintText: 'Enter Company Name',
                                      border: UnderlineInputBorder(),
                                      labelText: 'Enter Company Name',
                                    ),
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the Company Name';
                                      }
                                      return null;
                                    },
                                  ),
                                  TextFormField(
                                    controller: _controllerNumber,
                                    keyboardType: TextInputType.phone,
                                    decoration: const InputDecoration(
                                      // hintText: 'Enter Company Phone Number',
                                      border: UnderlineInputBorder(),
                                      labelText: 'Enter Company Phone Number',
                                    ),
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the Company Phone Number';
                                      }
                                      return null;
                                    },
                                  ),
                                  TextFormField(
                                    controller: _controllerEmail,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'Enter your email',
                                    ),
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter some text';
                                      } else if (value.contains('@') == false) {
                                        return 'Please enter a valid email';
                                      }
                                      return null;
                                    },
                                  ),
                                  TextFormField(
                                    controller: _controllerAbout,
                                    keyboardType: TextInputType.multiline,
                                    // expands: true,
                                    maxLines: null,
                                    decoration: const InputDecoration(
                                      // hintText: 'Enter Company Description',
                                      border: UnderlineInputBorder(),
                                      labelText: 'Enter Company Description',
                                    ),
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the Company Description';
                                      }
                                      return null;
                                    },
                                  ),
                                  DropdownButtonFormField(
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'Choose Floor',
                                    ),
                                    items: dropdownItems,
                                    value: selectedValue,
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the Floor';
                                      }
                                      return null;
                                    },
                                    onChanged: ((String? newValue) {
                                      selectedValue = newValue!;
                                      BlocProvider.of<VidicAdminBloc>(context)
                                          .add(CreateFloorEvent(
                                              floor: selectedValue));
                                      if (kDebugMode) {
                                        print("$selectedValue is select");
                                      }
                                    }),
                                  ),
                                  // TextFormField(
                                  //   controller: _controllerFloor,
                                  //   keyboardType: TextInputType.number,
                                  //   decoration: const InputDecoration(
                                  //     border: UnderlineInputBorder(),
                                  //     labelText: 'Enter Floor',
                                  //   ),
                                  //   validator: (String? value) {
                                  //     if (value == null || value.isEmpty) {
                                  //       return 'Please enter the Floor';
                                  //     }
                                  //     return null;
                                  //   },
                                  // ),
                                  TextFormField(
                                    controller: _controllerSize,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'Enter Floor Size(sq ft)',
                                    ),
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the Floor Size';
                                      }
                                      return null;
                                    },
                                  ),
                                  TextFormField(
                                    controller: _controllerRent,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'Enter Rent Amount (Ksh)',
                                    ),
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the Rent Amount';
                                      }
                                      return null;
                                    },
                                  ),
                                  TextFormField(
                                    controller: _controllerEscalation,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'Enter Rent Escalation (%)',
                                    ),
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the Rent Escalation';
                                      }
                                      return null;
                                    },
                                  ),
                                  TextFormField(
                                    controller: _controllerPoBox,
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'Enter P.O.Box',
                                    ),
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the P.O.Box';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const Text(
                                    'Lease Start Date',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                  SfDateRangePicker(
                                    onSelectionChanged:
                                        (DateRangePickerSelectionChangedArgs
                                            args) {
                                      BlocProvider.of<VidicAdminBloc>(context)
                                          .add(CreateStartDateEvent(
                                              startDate: args.value
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
                                    'Lease End Date',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                  SfDateRangePicker(
                                    onSelectionChanged:
                                        (DateRangePickerSelectionChangedArgs
                                            args) {
                                      BlocProvider.of<VidicAdminBloc>(context)
                                          .add(CreateEndDateEvent(
                                              endDate: args.value
                                                  .toString()
                                                  .replaceAll(
                                                      ' 00:00:00.000', '')));
                                    },
                                    selectionMode:
                                        DateRangePickerSelectionMode.single,
                                  ),
                                  // TextFormField(
                                  //   controller: _controllerLeaseStart,
                                  //   keyboardType: TextInputType.datetime,
                                  //   decoration: const InputDecoration(
                                  //     border: UnderlineInputBorder(),
                                  //     labelText:
                                  //         'Enter Lease Start Date (year-month-date) (2020-01-08)',
                                  //   ),
                                  //   validator: (String? value) {
                                  //     if (value == null || value.isEmpty) {
                                  //       return 'Please enter the Lease Start Date';
                                  //     }
                                  //     return null;
                                  //   },
                                  // ),
                                  // TextFormField(
                                  //   controller: _controllerLeaseEnd,
                                  //   keyboardType: TextInputType.datetime,
                                  //   decoration: const InputDecoration(
                                  //     border: UnderlineInputBorder(),
                                  //     labelText:
                                  //         'Enter Lease End Date (year-month-date) (2020-01-08)',
                                  //   ),
                                  //   validator: (String? value) {
                                  //     if (value == null || value.isEmpty) {
                                  //       return 'Please enter the Lease End Date';
                                  //     }
                                  //     return null;
                                  //   },
                                  // ),
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
                                                CreateTenantDataEvent(
                                                  name: _controllerName.text,
                                                  number: _controllerNumber.text
                                                      .toString(),
                                                  officialEmail:
                                                      _controllerEmail.text,
                                                  about: _controllerAbout.text,
                                                  floor: selectedValue,
                                                  size: _controllerSize.text
                                                      .toString(),
                                                  rent: _controllerRent.text
                                                      .toString(),
                                                  escalation:
                                                      _controllerEscalation.text
                                                          .toString(),
                                                  pobox: _controllerPoBox.text,
                                                  leaseStartDate:
                                                      _controllerLeaseStart
                                                          .text,
                                                  leaseEndDate:
                                                      _controllerLeaseEnd.text,
                                                  active: '1',
                                                ),
                                              );
                                              // _controllerName.text = '';
                                              // _controllerNumber.text = '';
                                              // _controllerEmail.text = '';
                                              // _controllerAbout.text = '';
                                              // selectedValue = null;
                                              // _controllerSize.text = '';
                                              // _controllerRent.text = '';
                                              // _controllerEscalation.text = '';
                                              // _controllerPoBox.text = '';
                                              // _controllerLeaseStart.text = '';
                                              // _controllerLeaseEnd.text = '';
                                            }
                                          },
                                          child: Row(
                                            children: const [
                                              Text('Create New Tenant'),
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
                                      : ElevatedButton(
                                          onPressed: () {},
                                          child: Row(
                                            children: const [
                                              Text('Creating New Tenant'),
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
                                    height: 30,
                                  ),
                                ],
                              ),
                            ),
                          )
                          // ElevatedButton(
                          //   onPressed: () {
                          //     BlocProvider.of<VidicAdminBloc>(context)
                          //         .add(TenantGetEvent());
                          //   },
                          //   child: const Text('back'),
                          // )
                        ],
                      ),
                    ),
                  );
                }
                return Expanded(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: SingleChildScrollView(
                      // scrollDirection: Axis.horizontal,
                      // physics: const NeverScrollableScrollPhysics(),
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
                                BlocConsumer<VidicAdminBloc, VidicAdminState>(
                                  listener: (context, state) {
                                    // TODO: implement listener
                                  },
                                  builder: (context, state) {
                                    if (state is TenantLoading) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    }
                                    if (state is TenantLoaded) {
                                      return ScrollConfiguration(
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
                                              for (var i = 0;
                                                  i < state.occupy.length;
                                                  i++)
                                                NewWidgetCardHome(
                                                    capacity: state
                                                        .occupy[i].capacity,
                                                    floor:
                                                        state.occupy[i].floor,
                                                    occupancy: state
                                                        .occupy[i].occupancy),
                                              // NewWidgetCardHome(),
                                            ],
                                          ),
                                        ),
                                      );
                                    }
                                    return const Text('Error Occured');
                                  },
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
                                BlocConsumer<VidicAdminBloc, VidicAdminState>(
                                  listener: (context, state) {
                                    // TODO: implement listener
                                  },
                                  builder: (context, state) {
                                    if (state is TenantLoading) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    }
                                    if (state is TenantLoaded) {
                                      return Align(
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
                                                    'Company Name',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                DataColumn(
                                                  label: Text(
                                                    'Email',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                DataColumn(
                                                  label: Text(
                                                    'Floor',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                DataColumn(
                                                  label: Text(
                                                    'Size (sq ft)',
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
                                                    i < state.data.length;
                                                    i++)
                                                  DataRow(
                                                    cells: [
                                                      DataCell(
                                                        IconButton(
                                                          icon: const Icon(
                                                              Icons.edit),
                                                          tooltip:
                                                              'Update Tenant',
                                                          onPressed: () {
                                                            BlocProvider.of<
                                                                        VidicAdminBloc>(
                                                                    context)
                                                                .add(
                                                              UpdateTenantEvent(
                                                                name: state
                                                                    .data[i]
                                                                    .name,
                                                                number: state
                                                                    .data[i]
                                                                    .number,
                                                                officialEmail: state
                                                                    .data[i]
                                                                    .officialEmail,
                                                                about: state
                                                                    .data[i]
                                                                    .about,
                                                                floor: state
                                                                    .data[i]
                                                                    .floor,
                                                                size: state
                                                                    .data[i]
                                                                    .size,
                                                                rent: state
                                                                    .data[i]
                                                                    .rent,
                                                                escalation: state
                                                                    .data[i]
                                                                    .escalation,
                                                                pobox: state
                                                                    .data[i]
                                                                    .pobox,
                                                                leaseStartDate:
                                                                    state
                                                                        .data[i]
                                                                        .leaseStartDate,
                                                                leaseEndDate: state
                                                                    .data[i]
                                                                    .leaseEndDate,
                                                                active: state
                                                                    .data[i]
                                                                    .active,
                                                                id: state
                                                                    .data[i]
                                                                    .datumId,
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                      DataCell(
                                                        Text(
                                                          state.data[i].name,
                                                        ),
                                                      ),
                                                      DataCell(
                                                        Text(
                                                          state.data[i]
                                                              .officialEmail,
                                                        ),
                                                      ),
                                                      DataCell(
                                                        Chip(
                                                          label: (state.data[i]
                                                                      .floor ==
                                                                  "0")
                                                              ? const Text(
                                                                  'Ground Floor',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                )
                                                              : (state.data[i]
                                                                          .floor ==
                                                                      "1")
                                                                  ? const Text(
                                                                      '1st Floor',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white),
                                                                    )
                                                                  : (state.data[i].floor ==
                                                                          "2")
                                                                      ? const Text(
                                                                          '2nd Floor',
                                                                          style:
                                                                              TextStyle(color: Colors.white),
                                                                        )
                                                                      : (state.data[i].floor ==
                                                                              "3")
                                                                          ? const Text(
                                                                              '3rd Floor',
                                                                              style: TextStyle(color: Colors.white),
                                                                            )
                                                                          : const Text(
                                                                              '4th Floor',
                                                                              style: TextStyle(color: Colors.white),
                                                                            ),
                                                          backgroundColor:
                                                              Colors.pink[300],
                                                        ),
                                                      ),
                                                      DataCell(
                                                        Text(
                                                          state.data[i].size,
                                                        ),
                                                      ),
                                                      DataCell(
                                                        Text(
                                                          state.data[i].rent,
                                                        ),
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
                                                              DeleteTenantRequestEvent(
                                                                id: state
                                                                    .data[i]
                                                                    .datumId,
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
                                      );
                                      // return ScrollConfiguration(
                                      //   behavior:
                                      //       ScrollConfiguration.of(context)
                                      //           .copyWith(
                                      //     dragDevices: {
                                      //       PointerDeviceKind.touch,
                                      //       PointerDeviceKind.mouse,
                                      //     },
                                      //   ),

                                      //   child: ListView.builder(
                                      //     shrinkWrap: true,
                                      //     // physics:
                                      //     //     const NeverScrollableScrollPhysics(),
                                      //     itemCount: state.data.length,
                                      //     itemBuilder: (BuildContext context,
                                      //         int index) {
                                      //       return ListTile(
                                      //           leading:
                                      //               const Icon(Icons.person),
                                      //           // trailing: const Text(
                                      //           //   "GFG",
                                      //           //   style: TextStyle(
                                      //           //       color: Colors.green, fontSize: 15),
                                      //           // ),
                                      //           title: SingleChildScrollView(
                                      //             // physics:
                                      //             //     const NeverScrollableScrollPhysics(),
                                      //             scrollDirection:
                                      //                 Axis.horizontal,
                                      //             child: Row(
                                      //               children: [
                                      //                 Text(state
                                      //                     .data[index].name),
                                      //                 const SizedBox(
                                      //                   width: 50,
                                      //                 ),
                                      //                 Text(state.data[index]
                                      //                     .officialEmail),
                                      //                 const SizedBox(
                                      //                   width: 50,
                                      //                 ),
                                      //                 Chip(
                                      //                   label: (state
                                      //                               .data[index]
                                      //                               .floor ==
                                      //                           "0")
                                      //                       ? const Text(
                                      //                           'Ground Floor',
                                      //                           style: TextStyle(
                                      //                               color: Colors
                                      //                                   .white),
                                      //                         )
                                      //                       : (state.data[index]
                                      //                                   .floor ==
                                      //                               "1")
                                      //                           ? const Text(
                                      //                               '1st Floor',
                                      //                               style: TextStyle(
                                      //                                   color: Colors
                                      //                                       .white),
                                      //                             )
                                      //                           : (state.data[index].floor ==
                                      //                                   "2")
                                      //                               ? const Text(
                                      //                                   '2nd Floor',
                                      //                                   style: TextStyle(
                                      //                                       color:
                                      //                                           Colors.white),
                                      //                                 )
                                      //                               : (state.data[index].floor ==
                                      //                                       "3")
                                      //                                   ? const Text(
                                      //                                       '3rd Floor',
                                      //                                       style:
                                      //                                           TextStyle(color: Colors.white),
                                      //                                     )
                                      //                                   : const Text(
                                      //                                       '4th Floor',
                                      //                                       style:
                                      //                                           TextStyle(color: Colors.white),
                                      //                                     ),
                                      //                   backgroundColor:
                                      //                       Colors.pink[300],
                                      //                 ),
                                      //                 // Chip(
                                      //                 //   label: const Text(
                                      //                 //     '1st Floor',
                                      //                 //     style: TextStyle(
                                      //                 //         color: Colors.white),
                                      //                 //   ),
                                      //                 //   backgroundColor: Colors.pink[300],
                                      //                 // ),
                                      //                 const SizedBox(
                                      //                   width: 50,
                                      //                 ),
                                      //                 Text(
                                      //                   "${state.data[index].size} sq ft",
                                      //                 ),
                                      //                 const SizedBox(
                                      //                   width: 50,
                                      //                 ),
                                      //                 Text(
                                      //                   "Ksh ${state.data[index].rent}",
                                      //                 ),
                                      //                 const SizedBox(
                                      //                   width: 20,
                                      //                 ),
                                      //                 const Icon(Icons.delete),
                                      //               ],
                                      //             ),
                                      //           ));
                                      //     },
                                      //   ),
                                      // );
                                    }
                                    return const Text('Error Occured');
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            // const Center(
            //   child: Text('data'),
            // )
          ],
        ),
        floatingActionButton: BlocConsumer<VidicAdminBloc, VidicAdminState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is TenantLoading) {
              return FloatingActionButton(
                // onPressed: _incrementCounter,
                // BlocProvider.of<PlansBloc>(context).add(GetPicsLoaded())
                onPressed: () {
                  // BlocProvider.of<VidicAdminBloc>(context)
                  //     .add(CreateTenantEvent());
                },

                tooltip: 'Loading',
                child: const CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }
            if (state is TenantLoaded) {
              return FloatingActionButton(
                // onPressed: _incrementCounter,
                // BlocProvider.of<PlansBloc>(context).add(GetPicsLoaded())
                onPressed: () {
                  BlocProvider.of<VidicAdminBloc>(context)
                      .add(CreateTenantEvent());
                },

                tooltip: 'Add Tenant',
                child: const Icon(Icons.add),
              );
            }
            if (state is CreateTenantState) {
              return FloatingActionButton(
                // onPressed: _incrementCounter,
                // BlocProvider.of<PlansBloc>(context).add(GetPicsLoaded())
                onPressed: () {
                  BlocProvider.of<VidicAdminBloc>(context)
                      .add(TenantGetEvent());
                },

                tooltip: 'Back',
                child: const Icon(Icons.close),
              );
            }
            if (state is UpdateTenantState) {
              return FloatingActionButton(
                // onPressed: _incrementCounter,
                // BlocProvider.of<PlansBloc>(context).add(GetPicsLoaded())
                onPressed: () {
                  BlocProvider.of<VidicAdminBloc>(context)
                      .add(TenantGetEvent());
                },

                tooltip: 'Back',
                child: const Icon(Icons.close),
              );
            }
            return const FloatingActionButton(
              // onPressed: _incrementCounter,
              // BlocProvider.of<PlansBloc>(context).add(GetPicsLoaded())
              onPressed: null,

              tooltip: 'Waiting',
              child: Icon(Icons.add),
            );
          },
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
