class CartModel {
  int id;
  int productId;
  String product;
  int count;

  CartModel(
      {required this.id,
      required this.productId,
      required this.product,
      required this.count});

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'],
      productId: json['product_id'],
      product: json['product'],
      count: json['count'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['product'] = product;
    data['count'] = count;
    return data;
  }
}
