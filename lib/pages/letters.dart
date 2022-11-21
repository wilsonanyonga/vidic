import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vidic/bloc/vidic_admin_bloc.dart';
import 'package:vidic/utils/dio_client.dart';
import 'package:vidic/widgets/menu_bar.dart';
import 'package:vidic/widgets/navigation_rail.dart';

class LettersScreen extends StatelessWidget {
  LettersScreen({Key? key}) : super(key: key);

  int _selectedIndex = 3;
  var mediaQsize, mediaQheight, mediaQwidth;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _controllerSubject = TextEditingController();
  final TextEditingController _controllerDate = TextEditingController();

  @override
  Widget build(BuildContext context) {
    mediaQsize = MediaQuery.of(context).size;
    mediaQheight = mediaQsize.height;
    mediaQwidth = mediaQsize.width;

    String? selectedTenant;

    return BlocProvider(
      create: (context) => VidicAdminBloc(
        RepositoryProvider.of<DioClient>(context),
      )..add(LetterGetEvent()),
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
                if (state is DeleteLetterSuccessState) {
                  AwesomeDialog(
                    context: context,
                    width: 600,
                    animType: AnimType.leftSlide,
                    headerAnimationLoop: false,
                    dismissOnBackKeyPress: false,
                    dialogType: DialogType.success,
                    showCloseIcon: true,
                    title: 'Letter Deleted Successfully',
                    btnOkText: "OK",
                    btnOkOnPress: () {
                      BlocProvider.of<VidicAdminBloc>(context)
                          .add(LetterGetEvent());
                    },
                    btnOkIcon: Icons.check_circle,
                    onDismissCallback: (type) {
                      debugPrint('Dialog Dissmiss from callback $type');
                    },
                  ).show();
                }
                // if (state is DeleteLetterSuccessLoadingState) {
                //   AwesomeDialog(
                //     width: 600,
                //     context: context,
                //     autoHide: const Duration(milliseconds: 1),
                //     // dismissOnBackKeyPress: false,
                //     // dialogType: DialogType.noHeader,
                //     animType: AnimType.rightSlide,
                //     customHeader: const CircularProgressIndicator(),
                //     title: 'Letter Being Deleted',
                //     desc: 'Kindly Wait.',
                //     btnCancelOnPress: null,
                //     btnOkOnPress: null,
                //   ).show();
                // }
                if (state is DeleteLetterRequestState) {
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
                          .add(LetterGetEvent());
                    },
                    btnOkOnPress: () {
                      BlocProvider.of<VidicAdminBloc>(context)
                          .add(DeleteLetterEvent());
                    },
                  ).show();
                }
                if (state is UpdateLetterBackOption) {
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
                          .add(LetterGetEvent());
                      _controllerSubject.text = '';
                      // _controllerAmount.text = '';
                      // _controllerPurpose.text = '';
                      // selectedValue = null;
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
                if (state is LetterBackOption) {
                  AwesomeDialog(
                    context: context,
                    width: 600,
                    animType: AnimType.leftSlide,
                    headerAnimationLoop: false,
                    dismissOnBackKeyPress: false,
                    dialogType: DialogType.success,
                    showCloseIcon: true,
                    title: 'Letters Updated Successfully',
                    desc:
                        'You can choose to either go back home or add a new Invoice',
                    btnCancelText: "Back Home",
                    btnOkText: "OK",
                    btnOkOnPress: () {
                      // debugPrint('OnClcik');
                      BlocProvider.of<VidicAdminBloc>(context)
                          .add(CreateLetterEvent());
                      _controllerSubject.text = '';
                      // _controllerPurpose.text = '';
                      // selectedValue = null;
                      selectedTenant = null;
                    },
                    btnOkIcon: Icons.check_circle,
                    btnCancelOnPress: () {
                      BlocProvider.of<VidicAdminBloc>(context)
                          .add(LetterGetEvent());
                      _controllerSubject.text = '';
                      // _controllerPurpose.text = '';
                      // selectedValue = null;
                      selectedTenant = null;
                    },
                    onDismissCallback: (type) {
                      debugPrint('Dialog Dissmiss from callback $type');
                    },
                  ).show();
                }
              },
              builder: (context, state) {
                if (state is DeleteLetterSuccessLoadingState) {
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
                            'Deleting Letter',
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
                if (state is UpdateLettersPatchState) {
                  _controllerSubject.text = state.subject;
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
                            'Update Letter',
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
                                  //   value: selectedTenant,
                                  //   validator: (String? value) {
                                  //     if (value == null || value.isEmpty) {
                                  //       return 'Please enter the Tenant';
                                  //     }
                                  //     return null;
                                  //   },
                                  //   onChanged: ((String? newValue) {
                                  //     selectedTenant = newValue!;
                                  //     BlocProvider.of<VidicAdminBloc>(context)
                                  //         .add(SetTenantLetterIdEvent(
                                  //       tenantLetterId: selectedTenant,
                                  //     ));
                                  //     if (kDebugMode) {
                                  //       print("$selectedTenant is select");
                                  //     }
                                  //   }),
                                  // ),
                                  TextFormField(
                                    controller: _controllerSubject,
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                      hintText: 'Enter Subject Of Letter',
                                      border: UnderlineInputBorder(),
                                      labelText: 'Enter Subject Of Letter',
                                    ),
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the Enter Subject Of Letter';
                                      }
                                      return null;
                                    },
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
                                          .add(UploadLetterUpdateFileEvent());
                                    },
                                    child: const Text('Upload Letter'),
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
                                                UpdateLettersPatchSendEvent(
                                                    subject: _controllerSubject
                                                        .text),
                                              );
                                            }
                                          },
                                          child: Row(
                                            children: const [
                                              Text('Update Letter'),
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
                                              const Text('Creating New Letter'),
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
                if (state is CreateLetterState) {
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
                            'Create A New Letter',
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
                                          .add(SetTenantLetterIdEvent(
                                        tenantLetterId: selectedTenant,
                                      ));
                                      if (kDebugMode) {
                                        print("$selectedTenant is select");
                                      }
                                    }),
                                  ),
                                  TextFormField(
                                    controller: _controllerSubject,
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                      hintText: 'Enter Subject Of Letter',
                                      border: UnderlineInputBorder(),
                                      labelText: 'Enter Subject Of Letter',
                                    ),
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the Enter Subject Of Letter';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    state.letterFileName,
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
                                          .add(UploadLetterFileEvent());
                                    },
                                    child: const Text('Upload Letter'),
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
                                                UploadTenantLetterEvent(
                                                  subject:
                                                      _controllerSubject.text,
                                                ),
                                              );
                                            }
                                          },
                                          child: Row(
                                            children: const [
                                              Text('Create New Letter'),
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
                                              const Text('Creating New Letter'),
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
                              'Letters',
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
                              if (state is LetterLoading) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              if (state is LetterLoaded) {
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
                                                  Text(state.data[index].name),
                                                  // const SizedBox(
                                                  //   width: 50,
                                                  // ),
                                                  // Text(state.data[index].officialEmail),
                                                  const SizedBox(
                                                    width: 50,
                                                  ),
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
                                        // for (var i = 0;
                                        //     i <
                                        //         state.data[index].lettersTypes
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
                                                      'Title',
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
                                                              .lettersTypes
                                                              .length;
                                                      i++)
                                                    DataRow(
                                                      cells: [
                                                        DataCell(
                                                          IconButton(
                                                            icon: const Icon(
                                                                Icons.edit),
                                                            tooltip:
                                                                'Update Letter',
                                                            onPressed: () {
                                                              BlocProvider.of<
                                                                          VidicAdminBloc>(
                                                                      context)
                                                                  .add(
                                                                UpdateLettersPatchEvent(
                                                                  id: state
                                                                      .data[
                                                                          index]
                                                                      .lettersTypes[
                                                                          i]
                                                                      .lettersTypeId,
                                                                  // date: state
                                                                  //     .data[
                                                                  //         index]
                                                                  //     .lettersTypes[
                                                                  //         i]
                                                                  //     .date
                                                                  //     .toString()
                                                                  //     .replaceAll(
                                                                  //         '21:00:00.000Z',
                                                                  //         ''),
                                                                  subject: state
                                                                      .data[
                                                                          index]
                                                                      .lettersTypes[
                                                                          i]
                                                                      .subject,
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                        DataCell(
                                                          Text(
                                                            state
                                                                .data[index]
                                                                .lettersTypes[i]
                                                                .subject,
                                                          ),
                                                        ),
                                                        DataCell(
                                                          Text(
                                                            state
                                                                .data[index]
                                                                .lettersTypes[i]
                                                                .date
                                                                .toString()
                                                                .replaceAll(
                                                                    '21:00:00.000Z',
                                                                    ''),
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
                                                                DeleteLetterRequestEvent(
                                                                  id: state
                                                                      .data[
                                                                          index]
                                                                      .lettersTypes[
                                                                          i]
                                                                      .lettersTypeId,
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
                                        //             state
                                        //                 .data[index]
                                        //                 .lettersTypes[i]
                                        //                 .subject,
                                        //           ),
                                        //           const SizedBox(
                                        //             width: 50,
                                        //           ),
                                        //           Text(
                                        //             "Date: ${state.data[index].lettersTypes[i].date.toString().replaceAll('21:00:00.000Z', '')}",
                                        //           ),
                                        //           const SizedBox(
                                        //             width: 50,
                                        //           ),
                                        //           const Icon(Icons.delete)
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
            if (state is CreateLetterState) {
              return FloatingActionButton(
                  onPressed: () {
                    BlocProvider.of<VidicAdminBloc>(context)
                        .add(LetterGetEvent());
                  },
                  tooltip: 'Go Back',
                  child: const Icon(Icons.close));
            }
            if (state is UpdateLettersPatchState) {
              return FloatingActionButton(
                  onPressed: () {
                    BlocProvider.of<VidicAdminBloc>(context)
                        .add(LetterGetEvent());
                  },
                  tooltip: 'Go Back',
                  child: const Icon(Icons.close));
            }
            if (state is LetterLoading) {
              return FloatingActionButton(
                onPressed: () {},
                tooltip: 'Loading',
                child: const CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }
            if (state is LetterLoaded) {
              return FloatingActionButton(
                onPressed: () {
                  BlocProvider.of<VidicAdminBloc>(context)
                      .add(CreateLetterEvent());
                },
                tooltip: 'Add New Statement',
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
