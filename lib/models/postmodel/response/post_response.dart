import 'package:product_flutter_app/models/postmodel/post_category.dart';
import 'user.dart';

class PostResponse {
  PostResponse({
    this.createAt,
    this.createBy,
    this.updateAt,
    this.updateBy,
    this.id,
    this.title,
    this.description,
    this.totalView,
    this.status,
    this.image,
    this.category,
    this.user,
  });

  String? createAt;
  String? createBy;
  String? updateAt;
  String? updateBy;
  int? id;
  String? title;
  String? description;
  int? totalView;
  String? status;
  String? image;
  PostCategory? category;
  User? user;

  PostResponse.fromJson(dynamic json) {
    createAt = json['createAt'] ?? '';
    createBy = json['createBy'] ?? 'Unknown';
    updateAt = json['updateAt'] ?? '';
    updateBy = json['updateBy'] ?? '';
    id = json['id'] ?? 0;
    title = json['title'] ?? 'No Title';
    description = json['description'] ?? 'No Description';
    totalView = json['totalView'] ?? 0;
    status = json['status'] ?? 'UNKNOWN';
    image = json['image'] ?? '';
    category = json['category'] != null ? PostCategory.fromJson(json['category']) : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['createAt'] = createAt;
    map['createBy'] = createBy;
    map['updateAt'] = updateAt;
    map['updateBy'] = updateBy;
    map['id'] = id;
    map['title'] = title;
    map['description'] = description;
    map['totalView'] = totalView;
    map['status'] = status;
    map['image'] = image;
    if (category != null) {
      map['category'] = category?.toJson();
    }
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }
}
