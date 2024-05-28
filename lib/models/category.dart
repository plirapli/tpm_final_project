class Categories {
  String? status;
  String? message;
  List<Category>? data;

  Categories({this.status, this.message, this.data});

  Categories.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Category>[];
      json['data'].forEach((v) {
        data!.add(Category.fromJson(v));
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

class Category {
  int? id;
  String? name;
  int? itemQty;

  Category({this.id, this.name, this.itemQty});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    itemQty = json['item_qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['item_qty'] = itemQty;
    return data;
  }
}
