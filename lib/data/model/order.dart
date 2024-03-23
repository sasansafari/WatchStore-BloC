class OrderDetail {
  int id;
  String product;
  int count;
  int price;
  int discountPrice;
  String status;

  OrderDetail({
    required this.id,
    required this.product,
    required this.count,
    required this.price,
    required this.discountPrice,
    required this.status,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    return OrderDetail(
      id: json['id'],
      product: json['product'],
      count: json['count'],
      price: json['price'],
      discountPrice: json['discount_price'],
      status: json['status'],
    );
  }
}

class Order {
  int id;
  int code;
  String status;
  List<OrderDetail> orderDetails;

  Order({
    required this.id,
    required this.code,
    required this.status,
    required this.orderDetails,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    var orderDetailsList = json['order_details'] as List;
    List<OrderDetail> orderDetails =
        orderDetailsList.map((detail) => OrderDetail.fromJson(detail)).toList();

    return Order(
      id: json['id'],
      code: json['code'],
      status: json['status'],
      orderDetails: orderDetails,
    );
  }
}
