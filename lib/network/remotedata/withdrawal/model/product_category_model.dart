// import 'package:inacash_bisnis/network/remotedata/withdrawal/model/product_group_one_model.dart';

// class ProductCategoryModel {
//   final int id;
//   final String name;
//   final String? info;
//   final String? icon;
//   final String? colorBackground;
//   final String? colorText;
//   final int reorder;
//   final List<ProductGroupOneModel> productGroupOnes;

//   ProductCategoryModel({
//     required this.id,
//     required this.name,
//     this.info,
//     this.icon,
//     this.colorBackground,
//     this.colorText,
//     required this.reorder,
//     required this.productGroupOnes,
//   });

//   factory ProductCategoryModel.fromJson(Map<String, dynamic> json) {
//     return ProductCategoryModel(
//       id: json['id'],
//       name: json['name'],
//       info: json['info'],
//       icon: json['icon'],
//       colorBackground: json['color_background'],
//       colorText: json['color_text'],
//       reorder: json['reorder'],
//       productGroupOnes: (json['product_group_ones'] as List<dynamic>)
//           .map((e) => ProductGroupOneModel.fromJson(e))
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
//       'product_group_ones': productGroupOnes.map((e) => e.toJson()).toList(),
//     };
//   }
// }
