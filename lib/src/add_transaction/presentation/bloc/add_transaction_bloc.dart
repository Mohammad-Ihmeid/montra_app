import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_transaction_event.dart';
part 'add_transaction_state.dart';

class AddTransactionBloc extends Bloc<AddTransactionEvent, AddTransactionState> {
  AddTransactionBloc() : super(AddTransactionInitial()) {
    on<AddTransactionEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
