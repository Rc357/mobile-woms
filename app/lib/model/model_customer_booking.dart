// @dart=2.10
class CustomerBookingModel {
  final String id;
  final String from;
  final String product_id;
  final String status;
  final String outlet_id;
  final String order_id;
  final String hold_order_id;
  final String product;
  final String statusTitle;
  final String booking_outlet;
  CustomerBookingModel({
    this.id,
    this.from,
    this.product_id,
    this.status,
    this.outlet_id,
    this.order_id,
    this.hold_order_id,
    this.product,
    this.statusTitle,
    this.booking_outlet,
  });

  factory CustomerBookingModel.fromJson(Map<String, dynamic> json) {
    return CustomerBookingModel(
      id: json['id'],
      from: json['from'],
      product_id: json['product_id'],
      status: json['status'],
      outlet_id: json['outlet_id'],
      order_id: json['order_id'],
      hold_order_id: json['hold_order_id'],
      product: json['product'],
      statusTitle: json['statusTitle'],
      booking_outlet: json['booking_outlet'],
    );
  }
}
