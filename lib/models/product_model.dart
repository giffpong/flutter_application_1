class ProductModel {
  // Field
  String name, detail, pathImage;

  // Method
  ProductModel(
    this.name,
    this.detail,
    this.pathImage,
  );

  ProductModel.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    detail = map['detail'];
    pathImage = map['path_image'];
  }
}
