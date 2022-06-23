// @dart=2.10
class ItemsOrder {
  final String id;
  final String sku;
  final String type;
  final String name;
  final String coupon_code;
  final String weight;
  final String total_weight;
  final String qty_ordered;
  final String qty_shipped;
  final String qty_invoiced;
  final String qty_canceled;
  final String qty_refunded;
  final String price;
  final String base_price;
  final String base_total;
  final String total_invoiced;
  final String base_total_invoiced;
  final String amount_refunded;
  final String base_amount_refunded;
  final String discount_percent;
  final String discount_amount;
  final String base_discount_amount;
  final String discount_invoiced;
  final String base_discount_invoiced;
  final String discount_refunded;
  final String base_discount_refunded;
  final String tax_percent;
  final String tax_amount;
  final String base_tax_amount;
  final String tax_amount_invoiced;
  final String base_tax_amount_invoiced;
  final String tax_amount_refunded;
  final String base_tax_amount_refunded;
  final String product_id;
  final String product_type;
  final String order_id;
  final String parent_id;
  final String additional;
  final String created_at;
  final String updated_at;
  ItemsOrder({
    this.id,
    this.sku,
    this.type,
    this.name,
    this.coupon_code,
    this.weight,
    this.total_weight,
    this.qty_ordered,
    this.qty_shipped,
    this.qty_invoiced,
    this.qty_canceled,
    this.qty_refunded,
    this.price,
    this.base_price,
    this.base_total,
    this.total_invoiced,
    this.base_total_invoiced,
    this.amount_refunded,
    this.base_amount_refunded,
    this.discount_percent,
    this.discount_amount,
    this.base_discount_amount,
    this.discount_invoiced,
    this.base_discount_invoiced,
    this.discount_refunded,
    this.base_discount_refunded,
    this.tax_percent,
    this.tax_amount,
    this.base_tax_amount,
    this.tax_amount_invoiced,
    this.base_tax_amount_invoiced,
    this.tax_amount_refunded,
    this.base_tax_amount_refunded,
    this.product_id,
    this.product_type,
    this.order_id,
    this.parent_id,
    this.additional,
    this.created_at,
    this.updated_at,
  });

  factory ItemsOrder.fromJson(Map<String, dynamic> json) {
    return ItemsOrder(
      id: json['id'],
      sku: json['sku'],
      type: json['type'],
      name: json['name'],
      coupon_code: json['coupon_code'],
      weight: json['weight'],
      total_weight: json['total_weight'],
      qty_ordered: json['qty_ordered'],
      qty_shipped: json['qty_shipped'],
      qty_invoiced: json['qty_invoiced'],
      qty_canceled: json['qty_canceled'],
      qty_refunded: json['qty_refunded'],
      price: json['price'],
      base_price: json['base_price'],
      base_total: json['base_total'],
      total_invoiced: json['total_invoiced'],
      base_total_invoiced: json['base_total_invoiced'],
      amount_refunded: json['amount_refunded'],
      base_amount_refunded: json['base_amount_refunded'],
      discount_percent: json['discount_percent'],
      discount_amount: json['discount_amount'],
      base_discount_amount: json['base_discount_amount'],
      discount_invoiced: json['discount_invoiced'],
      base_discount_invoiced: json['base_discount_invoiced'],
      discount_refunded: json['discount_refunded'],
      base_discount_refunded: json['base_discount_refunded'],
      tax_percent: json['tax_percent'],
      tax_amount: json['tax_amount'],
      base_tax_amount: json['base_tax_amount'],
      tax_amount_invoiced: json['tax_amount_invoiced'],
      base_tax_amount_invoiced: json['base_tax_amount_invoiced'],
      tax_amount_refunded: json['tax_amount_refunded'],
      base_tax_amount_refunded: json['base_tax_amount_refunded'],
      product_id: json['product_id'],
      product_type: json['product_type'],
      order_id: json['order_id'],
      parent_id: json['parent_id'],
      additional: json['additional'],
      created_at: json['created_at'],
      updated_at: json['updated_at '],
    );
  }
}
