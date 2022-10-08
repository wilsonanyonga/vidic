import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'vidic_admin_event.dart';
part 'vidic_admin_state.dart';

class VidicAdminBloc extends Bloc<VidicAdminEvent, VidicAdminState> {
  VidicAdminBloc() : super(VidicAdminInitial()) {
    on<VidicAdminEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
