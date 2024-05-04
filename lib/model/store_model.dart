import 'package:cloud_firestore/cloud_firestore.dart';

class StoreModel {
  String? sellerId;
  String? storeId;
  String? storeName;
  String? address;
  int? contact;
  String? description;
  String? storeLogo;
  DateTime? createdAt;

  StoreModel({
    this.sellerId,
    this.storeId,
    this.storeName,
    this.address,
    this.contact,
    this.description,
    this.storeLogo,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'sellerId': sellerId,
      'storeId': storeId,
      'storeName': storeName,
      'address': address,
      'contact': contact,
      'description': description,
      'storeLogo': storeLogo,
      'createdAt': createdAt,
    };
  }

  factory StoreModel.fromMap(DocumentSnapshot map) {
    return StoreModel(
      sellerId: map['sellerId'] as String,
      storeId: map['storeId'] as String,
      storeName: map['storeName'] as String,
      address: map['address'] as String,
      contact: map['contact'] as int,
      description: map['description'] as String,
      storeLogo: map['storeLogo'] as String,
      createdAt: (map['createdAt'].toDate()),
    );
  }
}
