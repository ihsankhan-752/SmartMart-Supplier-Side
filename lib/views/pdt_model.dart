import 'package:cloud_firestore/cloud_firestore.dart';

class PdtModel {
  String? category;
  String? pdtName;
  double? pdtPrice;
  int? discount;
  String? pdtDescription;
  String? pdtId;
  List<dynamic>? pdtImages;
  int? quantity;
  String? supplierId;

  PdtModel({
    this.category,
    this.pdtName,
    this.pdtId,
    this.supplierId,
    this.quantity,
    this.discount,
    this.pdtDescription,
    this.pdtImages,
    this.pdtPrice,
  });

  factory PdtModel.fromDocumentSnapshot(DocumentSnapshot data) {
    return PdtModel(
      category: data['category'],
      pdtName: data['pdtName'],
      pdtId: data['pdtId'],
      pdtDescription: data['pdtDescription'],
      discount: data['discount'],
      pdtPrice: data['price'],
      pdtImages: data['productImages'],
      quantity: data['quantity'],
      supplierId: data['supplierId'],
    );
  }
}
