class ProductDetailes {
  int? id;
  String? title;
  String? titleEn;
  int? price;
  int? discount;
  int? discountPrice;
  String? guaranty;
  int? productCount;
  String? category;
  int? categoryId;
  List<Colors>? colors;
  String? brand;
  int? brandId;
  int? review;
  String? image;
  List<Properties>? properties;
  String? description;
  String? discussion;
  List<Comments>? comments;

  ProductDetailes(
      {this.id,
      this.title,
      this.titleEn,
      this.price,
      this.discount,
      this.discountPrice,
      this.guaranty,
      this.productCount,
      this.category,
      this.categoryId,
      this.colors,
      this.brand,
      this.brandId,
      this.review,
      this.image,
      this.properties,
      this.description,
      this.discussion,
      this.comments});

  ProductDetailes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    titleEn = json['title_en'];
    price = json['price'];
    discount = json['discount'];
    discountPrice = json['discount_price'];
    guaranty = json['guaranty'];
    productCount = json['product_count'];
    category = json['category'];
    categoryId = json['category_id'];
    if (json['colors'] != null) {
      colors = <Colors>[];
      json['colors'].forEach((v) {
        colors!.add(Colors.fromJson(v));
      });
    }
    brand = json['brand'];
    brandId = json['brand_id'];
    review = json['review'];
    image = json['image'];
    if (json['properties'] != null) {
      properties = <Properties>[];
      json['properties'].forEach((v) {
        properties!.add(Properties.fromJson(v));
      });
    }
    description = json['description'];
    discussion = json['discussion'];
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(Comments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['title_en'] = titleEn;
    data['price'] = price;
    data['discount'] = discount;
    data['discount_price'] = discountPrice;
    data['guaranty'] = guaranty;
    data['product_count'] = productCount;
    data['category'] = category;
    data['category_id'] = categoryId;
    if (colors != null) {
      data['colors'] = colors!.map((v) => v.toJson()).toList();
    }
    data['brand'] = brand;
    data['brand_id'] = brandId;
    data['review'] = review;
    data['image'] = image;
    if (properties != null) {
      data['properties'] = properties!.map((v) => v.toJson()).toList();
    }
    data['description'] = description;
    data['discussion'] = discussion;
    if (comments != null) {
      data['comments'] = comments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Colors {
  String? title;
  String? code;

  Colors({this.title, this.code});

  Colors.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['title'] = title;
    data['code'] = code;
    return data;
  }
}

class Properties {
  String? property;
  String? value;

  Properties({this.property, this.value});

  Properties.fromJson(Map<String, dynamic> json) {
    property = json['property'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['property'] = property;
    data['value'] = value;
    return data;
  }
}

class Comments {
  String? user;
  String? body;

  Comments({this.user, this.body});

  Comments.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['user'] = user;
    data['body'] = body;
    return data;
  }
}
