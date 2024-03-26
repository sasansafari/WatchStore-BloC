class CartModel {
  int id;
  int productId;
  String product;
  int count;
  int price;
  int discount;
  int discountPrice;
  String image;
  bool countLoading = false;
  bool deleteLoading = false;
  CartModel(
      {required this.id,
      required this.productId,
      required this.product,
      required this.price,
      required this.discountPrice,
      required this.discount,
      required this.image,
      this.countLoading = false,
      this.deleteLoading = false,
      required this.count});

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'],
      productId: json['product_id'],
      product: json['product'],
      count: json['count'],
      price: json['price'],
      discount: json['discount'],
      discountPrice: json['discount_price'],
      image: json['image'],
    );
  }
}

class UserCart {
  List<CartModel> cartList;
  int cartTotalPrice;
  int totalWithoutDiscountPrice;

  UserCart(
      {required this.cartList,
      required this.cartTotalPrice,
      required this.totalWithoutDiscountPrice});

  factory UserCart.fromJson(Map<String, dynamic> json) {
    List<dynamic> userCartJson = json['user_cart'];
    List<CartModel> cartList =
        userCartJson.map((e) => CartModel.fromJson(e)).toList();

    return UserCart(
        cartList: cartList,
        cartTotalPrice: json['cart_total_price'],
        totalWithoutDiscountPrice: json['total_without_discount_price']);
  }
}
