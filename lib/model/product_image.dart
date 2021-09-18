class ProductImage {
  ProductImage({
    required this.proImgId,
    required this.productId,
    this.proImgAddr = "",
    required this.timeReg,
  });

  String proImgId;
  String productId;
  String proImgAddr;
  DateTime timeReg;

  factory ProductImage.fromJson(Map<String, dynamic> json) => ProductImage(
        proImgId: json["pro_img_id"],
        productId: json["product_id"],
        proImgAddr: json["pro_img_addr"],
        timeReg: DateTime.parse(json["time_reg"]),
      );

  Map<String, dynamic> toJson() => {
        "pro_img_id": proImgId,
        "product_id": productId,
        "pro_img_addr": proImgAddr,
        "time_reg": timeReg.toIso8601String(),
      };
}
