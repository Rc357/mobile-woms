// @dart=2.10
class DateAndEventsPos {
  final String id;
  final String qty;
  final String from;
  final String to;
  final String order_item_id;
  final String booking_product_event_ticket_id;
  final String order_id;
  final String product_id;
  final String employee_id;
  final String room_id;
  final String hold_order_item_id;
  final String hold_order_id;
  final String status;
  final String customer_id;
  final String created_at;
  final String updated_at;
  final String deleted_at;
  final String checked_in_time;
  final String start_time;
  final String end_time;
  final String checked_out_time;
  final String cashier_id;
  final String before_pending_actions_status;
  final String before_voicemail_sent_status;
  final String esthetician_is_requested;
  final String before_no_voicemail_status;
  final String before_no_show_status;
  final String reschedule_by;
  final String is_multiple;
  final String sms_confirmation_sent;
  final String sms_auto_call_sent;
  final String confirmed_via_sms;
  final String confirmed_via_auto_call;
  final String sms_reply_value;
  final String cancelled_time;
  final String no_show_time;
  DateAndEventsPos({
    this.id,
    this.qty,
    this.from,
    this.to,
    this.order_item_id,
    this.booking_product_event_ticket_id,
    this.order_id,
    this.product_id,
    this.employee_id,
    this.room_id,
    this.hold_order_item_id,
    this.hold_order_id,
    this.status,
    this.customer_id,
    this.created_at,
    this.updated_at,
    this.deleted_at,
    this.checked_in_time,
    this.start_time,
    this.end_time,
    this.checked_out_time,
    this.cashier_id,
    this.before_pending_actions_status,
    this.before_voicemail_sent_status,
    this.esthetician_is_requested,
    this.before_no_voicemail_status,
    this.before_no_show_status,
    this.reschedule_by,
    this.is_multiple,
    this.sms_confirmation_sent,
    this.sms_auto_call_sent,
    this.confirmed_via_sms,
    this.confirmed_via_auto_call,
    this.sms_reply_value,
    this.cancelled_time,
    this.no_show_time,
  });

  factory DateAndEventsPos.fromJson(Map<String, dynamic> json) {
    return DateAndEventsPos(
      id: json['id'],
      qty: json['qty'],
      from: json['from'],
      to: json['to'],
      order_item_id: json['order_item_id'],
      booking_product_event_ticket_id: json['booking_product_event_ticket_id'],
      order_id: json['order_id'],
      product_id: json['product_id'],
      employee_id: json['employee_id'],
      room_id: json['room_id'],
      hold_order_item_id: json['hold_order_item_id'],
      hold_order_id: json['hold_order_id'],
      status: json['status'],
      customer_id: json['customer_id'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
      deleted_at: json['deleted_at'],
      checked_in_time: json['checked_in_time'],
      start_time: json['start_time'],
      end_time: json['end_time'],
      checked_out_time: json['checked_out_time'],
      cashier_id: json['cashier_id'],
      before_pending_actions_status: json['before_pending_actions_status'],
      before_voicemail_sent_status: json['before_voicemail_sent_status'],
      esthetician_is_requested: json['esthetician_is_requested'],
      before_no_voicemail_status: json['before_no_voicemail_status'],
      before_no_show_status: json['before_no_show_status'],
      reschedule_by: json['reschedule_by'],
      is_multiple: json['is_multiple'],
      sms_confirmation_sent: json['sms_confirmation_sent'],
      sms_auto_call_sent: json['sms_auto_call_sent'],
      confirmed_via_sms: json['confirmed_via_sms'],
      confirmed_via_auto_call: json['confirmed_via_auto_call'],
      sms_reply_value: json['sms_reply_value'],
      cancelled_time: json['cancelled_time'],
      no_show_time: json['no_show_time'],
    );
  }
}
