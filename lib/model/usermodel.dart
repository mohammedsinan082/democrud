import 'package:cloud_firestore/cloud_firestore.dart';

class Modeluser {
  String name;
  String email;
  String id;
  bool delete;
  DateTime date;
  DocumentReference reference;



  Modeluser({
    required this.email,
    required this.id,
    required this.delete,
    required this.date,
    required this.name,
    required this.reference,


  });

  Modeluser copyWith({
    String? name,                 //used for update data
    String? email,
    String? id,
    bool? delete,
    DateTime? date,
    DocumentReference? reference,
  }) =>
      Modeluser(
        name: name ?? this.name,           // if null occur take current data
        email: email ?? this.email,
        id: id ?? this.id,
        delete: delete ?? this.delete,
        date: date ?? this.date,
        reference: reference ?? this.reference,
      );

  factory Modeluser.fromJson(Map<String, dynamic> json) => Modeluser(
    name: json["name"],
    email:json["email"],                          //to invoke data from firebase
    id: json["id"],
    delete: json["delete"],
    date:json["date"].toDate(),
    reference:json["reference"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,                                   //to add data to firebase
    "id": id,
    "delete": delete,
    "date":date,
    "reference": reference,
  };
}