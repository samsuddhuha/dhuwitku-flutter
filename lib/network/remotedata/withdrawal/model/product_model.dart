// import 'package:inacash_bisnis/network/remotedata/withdrawal/model/price_type_model.dart';

// class ProductModel {
//   final int id;
//   final String code;
//   final String name;
//   final String? info;
//   final String? icon;
//   final String? colorBackground;
//   final String? colorText;
//   final int reorder;
//   final int price;
//   final int markup;
//   final int admin;
//   final int productGroupTwoId;
//   final int priceTypeId;
//   final int? markupUser;
//   final PriceTypeModel priceType;

//   ProductModel({
//     required this.id,
//     required this.code,
//     required this.name,
//     this.info,
//     this.icon,
//     this.colorBackground,
//     this.colorText,
//     required this.reorder,
//     required this.price,
//     required this.markup,
//     required this.admin,
//     required this.productGroupTwoId,
//     required this.priceTypeId,
//     this.markupUser,
//     required this.priceType,
//   });

//   factory ProductModel.fromJson(Map<String, dynamic> json) {
//     return ProductModel(
//       id: json['id'],
//       code: json['code'],
//       name: json['name'],
//       info: json['info'],
//       icon: json['icon'],
//       colorBackground: json['color_background'],
//       colorText: json['color_text'],
//       reorder: json['reorder'],
//       price: json['price'],
//       markup: json['markup'],
//       admin: json['admin'],
//       productGroupTwoId: json['product_group_two_id'],
//       priceTypeId: json['price_type_id'],
//       markupUser: json['markup_user'],
//       priceType: PriceTypeModel.fromJson(json['price_type']),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'code': code,
//       'name': name,
//       'info': info,
//       'icon': icon,
//       'color_background': colorBackground,
//       'color_text': colorText,
//       'reorder': reorder,
//       'price': price,
//       'markup': markup,
//       'admin': admin,
//       'product_group_two_id': productGroupTwoId,
//       'price_type_id': priceTypeId,
//       'markup_user': markupUser,
//       'price_type': priceType.toJson(),
//     };
//   }
// }
