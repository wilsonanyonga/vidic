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

  @override
  Widget build(BuildContext context) {
    mediaQsize = MediaQuery.of(context).size;
    mediaQheight = mediaQsize.height;
    mediaQwidth = mediaQsize.width;

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
            Expanded(
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
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: [
                                  ListTile(
                                    leading: const Icon(Icons.person),
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
                                        Text(state.data[index].officialEmail),
                                        const SizedBox(
                                          width: 50,
                                        ),
                                        Chip(
                                          label: Text(
                                            '${state.data[index].floor} Floor',
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                          backgroundColor: Colors.pink[300],
                                        ),
                                        const SizedBox(
                                          width: 50,
                                        ),
                                        Text("${state.data[index].size} sq ft"),
                                        // const SizedBox(
                                        //   width: 50,
                                        // ),
                                        // const Text("18/5/2021"),
                                        const SizedBox(
                                          width: 50,
                                        ),
                                        Text("Ksh ${state.data[index].rent}"),
                                      ],
                                    ),
                                  ),
                                  for (var i = 0;
                                      i < state.data[index].invoiceTypes.length;
                                      i++)
                                    Text(state
                                        .data[index].invoiceTypes[i].amount
                                        .toString()),
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
          ],
        ),
      ),
    );
  }
}
