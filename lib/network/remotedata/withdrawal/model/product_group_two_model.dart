// import 'package:inacash_bisnis/network/remotedata/withdrawal/model/product_model.dart';

// class ProductGroupTwoModel {
//   final int id;
//   final String name;
//   final String? info;
//   final String? prefix;
//   final String? icon;
//   final String? colorBackground;
//   final String? colorText;
//   final int reorder;
//   final int productGroupOneId;
//   final List<ProductModel> products;

//   ProductGroupTwoModel({
//     required this.id,
//     required this.name,
//     this.info,
//     this.prefix,
//     this.icon,
//     this.colorBackground,
//     this.colorText,
//     required this.reorder,
//     required this.productGroupOneId,
//     required this.products,
//   });

//   factory ProductGroupTwoModel.fromJson(Map<String, dynamic> json) {
//     return ProductGroupTwoModel(
//       id: json['id'],
//       name: json['name'],
//       info: json['info'],
//       prefix: json['prefix'],
//       icon: json['icon'],
//       colorBackground: json['color_background'],
//       colorText: json['color_text'],
//       reorder: json['reorder'],
//       productGroupOneId: json['product_group_one_id'],
//       products: (json['products'] as List<dynamic>)
//           .map((e) => ProductModel.fromJson(e))
//           .toList(),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'info': info,
//       'prefix': prefix,
//       'icon': icon,
//       'color_background': colorBackground,
//       'color_text': colorText,
//       'reorder': reorder,
//       'product_group_one_id': productGroupOneId,
//       'products': products.map((e) => e.toJson()).toList(),
//     };
//   }
// }
