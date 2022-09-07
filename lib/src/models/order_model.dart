import 'package:greengrocer_course/src/models/cart_item_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel {
  String id;
  DateTime? cratedDateTime;
  
  @JsonKey(name: 'due')
  DateTime overdueDateTime;

  @JsonKey(defaultValue: [])
  List<CartItemModel?> items;
  String status;
  
  String qrCodeImage;
  
  @JsonKey(name: 'copiaecola')
  String copyAndPaste;
  double total;

  OrderModel({
    required this.id,
    this.cratedDateTime,
    required this.overdueDateTime,
    required this.items,
    required this.status,
    required this.qrCodeImage,
    required this.copyAndPaste,
    required this.total
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);

}