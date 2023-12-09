import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String image;
  String prdctName;
  String description;
  double amount;
  String id;
  bool delete;
  DocumentReference reference;
  DateTime date;
  String category;
  bool available;

  ProductModel({
    required this.image,
    required this.prdctName,
    required this.description,
    required this.amount,
    required this.id,
    required this.delete,
    required this.reference,
    required this.date,
    required this.category,
    required this.available,
  });

  ProductModel copyWith({
    String? image,
    String? prdctName,
    String? description,                           //used for update data
    double? amount,
    String? id,
    bool? delete,
    DocumentReference? reference,
    DateTime? date,
    String? category,
    bool? available,
  }) =>
      ProductModel(
        image: image ?? this.image,
        prdctName: prdctName ?? this.prdctName,
        description: description ?? this.description,               // if null occur take current data
        amount: amount ?? this.amount,
        id: id ?? this.id,
        delete: delete ?? this.delete,
        reference: reference ?? this.reference,
        date: date ?? this.date,
        category: category ?? this.category,
        available: available ?? this.available,
      );

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    image: json["image"],
    prdctName: json["prdctName"],
    description: json["description"],
    amount: double.tryParse(json["amount"].toString()) ?? 0,    //to invoke data from firebase
    id: json["id"],
    delete: json["delete"],
    reference:json["reference"],
    date:json["date"].toDate(),
    category: json["category"],
    available: json["available"],
  );

  Map<String, dynamic> toJson() => {
    "image": image,
    "prdctName": prdctName,
    "description": description,
    "amount": amount,                                   //to add data to firebase
    "id": id,
    "delete": delete,
    "reference": reference,
    "date":date,
    "category": category,
    "available": available,
  };
}