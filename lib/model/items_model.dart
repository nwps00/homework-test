import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'items_model.g.dart';

@JsonSerializable()
class Items extends Equatable {
  const Items({this.items, this.message});

  final List<Item>? items;
  final String? message;

  factory Items.fromJson(Map<String, dynamic> json) => _$ItemsFromJson(json);

  static List<Items> fromJsonList(List jsonList) =>
      List<Items>.from(jsonList.map((e) => Items.fromJson(e)));

  @override
  List<Object?> get props => [items, message];

  @override
  String toString() {
    return 'Items{items: $items, message: $message}';
  }
}

@JsonSerializable()
class Item extends Equatable {
  const Item({this.id, this.name, this.price, this.amount = 0});

  final int? id;
  final String? name;
  final double? price;
  final int? amount;

  Item copyWith({int? id, String? name, double? price, int? amount}) {
    return Item(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      amount: amount ?? this.amount,
    );
  }

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  static List<Item> fromJsonList(List jsonList) =>
      List<Item>.from(jsonList.map((e) => Item.fromJson(e)));

  @override
  List<Object?> get props => [id, name, price];

  @override
  String toString() {
    return 'Item{id: $id, name: $name, price: $price}';
  }
}
