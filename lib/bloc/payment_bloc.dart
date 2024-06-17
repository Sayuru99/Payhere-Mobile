import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:myapp/payment_service.dart';
import 'package:payhere_mobilesdk_flutter/payhere_mobilesdk_flutter.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(PaymentInitial()) {
    on<InitiatePaymentEvent>(_onInitiatePayment);
  }

  Future<void> _onInitiatePayment(
    InitiatePaymentEvent event,
    Emitter<PaymentState> emit,
  ) async {
    emit(PaymentInProgress());

    try {
      final paymentObject = PaymentService.createPaymentObject();

      PayHere.startPayment(paymentObject, (paymentId) {
        emit(PaymentSuccess(paymentId));
      }, (error) {
        emit(PaymentFailure(error));
      }, () {
        emit(PaymentCancelled());
      });
    } catch (e) {
      emit(PaymentFailure(e.toString()));
    }
  }
}
