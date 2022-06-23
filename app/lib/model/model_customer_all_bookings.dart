// @dart=2.10
//     final customerAllBookingsModel = customerAllBookingsModelFromJson(jsonString);

import 'dart:convert';

Map<String, dynamic> customerAllBookingsModelFromJson(String str) =>
    Map.from(json.decode(str)).map((k, v) => MapEntry<String, dynamic>(k, v));

String customerAllBookingsModelToJson(Map<String, dynamic> data) =>
    json.encode(Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v)));

class CustomerAllBookingsModelElement {
  CustomerAllBookingsModelElement({
    this.id,
    this.qty,
    this.from,
    this.to,
    this.orderItemId,
    this.bookingProductEventTicketId,
    this.orderId,
    this.productId,
    this.employeeId,
    this.roomId,
    this.holdOrderItemId,
    this.holdOrderId,
    this.outletId,
    this.status,
    this.customerId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.checkedInTime,
    this.startTime,
    this.endTime,
    this.checkedOutTime,
    this.cashierId,
    this.beforePendingActionsStatus,
    this.beforeVoicemailSentStatus,
    this.estheticianIsRequested,
    this.beforeNoVoicemailStatus,
    this.beforeNoShowStatus,
    this.rescheduleBy,
    this.isMultiple,
    this.smsConfirmationSent,
    this.smsAutoCallSent,
    this.confirmedViaSms,
    this.confirmedViaAutoCall,
    this.smsReplyValue,
    this.cancelledTime,
    this.noShowTime,
    this.actualTime,
    this.smsRepliedTime,
    this.reasonForCancellation,
    this.date,
    this.time,
  });

  int id;
  int qty;
  int from;
  int to;
  int orderItemId;
  dynamic bookingProductEventTicketId;
  int orderId;
  int productId;
  int employeeId;
  int roomId;
  int holdOrderItemId;
  int holdOrderId;
  int outletId;
  String status;
  int customerId;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  DateTime checkedInTime;
  DateTime startTime;
  DateTime endTime;
  DateTime checkedOutTime;
  int cashierId;
  String beforePendingActionsStatus;
  dynamic beforeVoicemailSentStatus;
  int estheticianIsRequested;
  dynamic beforeNoVoicemailStatus;
  dynamic beforeNoShowStatus;
  int rescheduleBy;
  int isMultiple;
  int smsConfirmationSent;
  int smsAutoCallSent;
  int confirmedViaSms;
  int confirmedViaAutoCall;
  dynamic smsReplyValue;
  DateTime cancelledTime;
  dynamic noShowTime;
  int actualTime;
  dynamic smsRepliedTime;
  String reasonForCancellation;
  DateTime date;
  String time;

  factory CustomerAllBookingsModelElement.fromJson(Map<String, dynamic> json) =>
      CustomerAllBookingsModelElement(
        id: json["id"],
        qty: json["qty"],
        from: json["from"],
        to: json["to"],
        orderItemId:
            json["order_item_id"] == null ? null : json["order_item_id"],
        bookingProductEventTicketId: json["booking_product_event_ticket_id"],
        orderId: json["order_id"] == null ? null : json["order_id"],
        productId: json["product_id"],
        employeeId: json["employee_id"],
        roomId: json["room_id"],
        holdOrderItemId: json["hold_order_item_id"] == null
            ? null
            : json["hold_order_item_id"],
        holdOrderId:
            json["hold_order_id"] == null ? null : json["hold_order_id"],
        outletId: json["outlet_id"],
        status: json["status"],
        customerId: json["customer_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        checkedInTime: json["checked_in_time"] == null
            ? null
            : DateTime.parse(json["checked_in_time"]),
        startTime: json["start_time"] == null
            ? null
            : DateTime.parse(json["start_time"]),
        endTime:
            json["end_time"] == null ? null : DateTime.parse(json["end_time"]),
        checkedOutTime: json["checked_out_time"] == null
            ? null
            : DateTime.parse(json["checked_out_time"]),
        cashierId: json["cashier_id"],
        beforePendingActionsStatus:
            json["before_pending_actions_status"] == null
                ? null
                : json["before_pending_actions_status"],
        beforeVoicemailSentStatus: json["before_voicemail_sent_status"],
        estheticianIsRequested: json["esthetician_is_requested"],
        beforeNoVoicemailStatus: json["before_no_voicemail_status"],
        beforeNoShowStatus: json["before_no_show_status"],
        rescheduleBy:
            json["reschedule_by"] == null ? null : json["reschedule_by"],
        isMultiple: json["is_multiple"],
        smsConfirmationSent: json["sms_confirmation_sent"],
        smsAutoCallSent: json["sms_auto_call_sent"],
        confirmedViaSms: json["confirmed_via_sms"],
        confirmedViaAutoCall: json["confirmed_via_auto_call"],
        smsReplyValue: json["sms_reply_value"],
        cancelledTime: json["cancelled_time"] == null
            ? null
            : DateTime.parse(json["cancelled_time"]),
        noShowTime: json["no_show_time"],
        actualTime: json["actual_time"],
        smsRepliedTime: json["sms_replied_time"],
        reasonForCancellation: json["reason_for_cancellation"],
        date: DateTime.parse(json["date"]),
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "qty": qty,
        "from": from,
        "to": to,
        "order_item_id": orderItemId == null ? null : orderItemId,
        "booking_product_event_ticket_id": bookingProductEventTicketId,
        "order_id": orderId == null ? null : orderId,
        "product_id": productId,
        "employee_id": employeeId,
        "room_id": roomId,
        "hold_order_item_id": holdOrderItemId == null ? null : holdOrderItemId,
        "hold_order_id": holdOrderId == null ? null : holdOrderId,
        "outlet_id": outletId,
        "status": status,
        "customer_id": customerId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "checked_in_time":
            checkedInTime == null ? null : checkedInTime.toIso8601String(),
        "start_time": startTime == null ? null : startTime.toIso8601String(),
        "end_time": endTime == null ? null : endTime.toIso8601String(),
        "checked_out_time":
            checkedOutTime == null ? null : checkedOutTime.toIso8601String(),
        "cashier_id": cashierId,
        "before_pending_actions_status": beforePendingActionsStatus == null
            ? null
            : beforePendingActionsStatus,
        "before_voicemail_sent_status": beforeVoicemailSentStatus,
        "esthetician_is_requested": estheticianIsRequested,
        "before_no_voicemail_status": beforeNoVoicemailStatus,
        "before_no_show_status": beforeNoShowStatus,
        "reschedule_by": rescheduleBy == null ? null : rescheduleBy,
        "is_multiple": isMultiple,
        "sms_confirmation_sent": smsConfirmationSent,
        "sms_auto_call_sent": smsAutoCallSent,
        "confirmed_via_sms": confirmedViaSms,
        "confirmed_via_auto_call": confirmedViaAutoCall,
        "sms_reply_value": smsReplyValue,
        "cancelled_time":
            cancelledTime == null ? null : cancelledTime.toIso8601String(),
        "no_show_time": noShowTime,
        "actual_time": actualTime,
        "sms_replied_time": smsRepliedTime,
        "reason_for_cancellation": reasonForCancellation,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "time": time,
      };
}
