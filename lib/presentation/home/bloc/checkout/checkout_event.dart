part of 'checkout_bloc.dart';

@freezed
class CheckoutEvent with _$CheckoutEvent {
  const factory CheckoutEvent.started() = _Started;
  //add Checkout
  const factory CheckoutEvent.addCheckout(Product product) = _AddCheckout;
  //remove Checkout
  const factory CheckoutEvent.removeCheckout(Product product) = _RemoveCheckout;
  //remove item Checkout
  const factory CheckoutEvent.removeItemCheckout(Product product) =
      _RemoveItemCheckout;
}
