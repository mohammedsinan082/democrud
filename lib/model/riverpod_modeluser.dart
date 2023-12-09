import 'package:cloud_firestore/cloud_firestore.dart';

class RiverpodModelUser{
  String name;
  String email;
  String id;
  bool delete;
  DocumentReference reference;

  RiverpodModelUser({
    required this.name,
    required this.email,
    required this.id,
    required this.delete,
    required this.reference
  });

  RiverpodModelUser copyWith({
    String? name,
    String? email,
    String? id,
    bool? delete,
    DocumentReference? reference
}) => RiverpodModelUser(
      name: name ?? this.name,
      email: email ?? this.email,
      id: id ?? this.id,
      delete: delete ?? this.delete,
      reference: reference?? this.reference
  );
  factory RiverpodModelUser.fromJson(Map<String,dynamic> json) =>RiverpodModelUser(
      name: json['name'],
      email: json['email'],
      id: json['id'],
      delete: json['delete'],
      reference: json['reference']
      );

   Map<String,dynamic> toJson()=> {
     "name":name,
     "email":email,
     "id":id,
     "delete":delete,
     "reference":reference,
   };

}