class Products {
  String? status;
  String? message;
  List<Product>? data;

  Products({this.status, this.message, this.data});

  Products.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Product>[];
      json['data'].forEach((v) {
        data!.add(Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  int? id;
  String? name;
  int? qty;
  int? price;
  int? categoryId;
  String? createdAt;
  String? updatedAt;

  Product({
    this.id,
    this.name,
    this.qty,
    this.price,
    this.categoryId,
    this.createdAt,
    this.updatedAt,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    qty = json['qty'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['qty'] = qty;
    data['price'] = price;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
