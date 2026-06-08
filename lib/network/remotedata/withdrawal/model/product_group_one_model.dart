// import 'package:inacash_bisnis/network/remotedata/withdrawal/model/product_group_two_model.dart';

// class ProductGroupOneModel {
//   final int id;
//   final String name;
//   final String? info;
//   final String? icon;
//   final String? colorBackground;
//   final String? colorText;
//   final int reorder;
//   final int productCategoryId;
//   final List<ProductGroupTwoModel> productGroupTwos;

//   ProductGroupOneModel({
//     required this.id,
//     required this.name,
//     this.info,
//     this.icon,
//     this.colorBackground,
//     this.colorText,
//     required this.reorder,
//     required this.productCategoryId,
//     required this.productGroupTwos,
//   });

//   factory ProductGroupOneModel.fromJson(Map<String, dynamic> json) {
//     return ProductGroupOneModel(
//       id: json['id'],
//       name: json['name'],
//       info: json['info'],
//       icon: json['icon'],
//       colorBackground: json['color_background'],
//       colorText: json['color_text'],
//       reorder: json['reorder'],
//       productCategoryId: json['product_category_id'],
//       productGroupTwos: (json['product_group_twos'] as List<dynamic>)
//           .map((e) => ProductGroupTwoModel.fromJson(e))
//           .toList(),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'info': info,
//       'icon': icon,
//       'color_background': colorBackground,
//       'color_text': colorText,
//       'reorder': reorder,
//       'product_category_id': productCategoryId,
//       'product_group_twos': productGroupTwos.map((e) => e.toJson()).toList(),
//     };
//   }
// }
