part of 'payment_bloc.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

class PaymentInitial extends PaymentState {}

class PaymentInProgress extends PaymentState {}

class PaymentSuccess extends PaymentState {
  final String paymentId;

  const PaymentSuccess(this.paymentId);

  @override
  List<Object> get props => [paymentId];
}

class PaymentFailure extends PaymentState {
  final String error;

  const PaymentFailure(this.error);

  @override
  List<Object> get props => [error];
}

class PaymentCancelled extends PaymentState {}
