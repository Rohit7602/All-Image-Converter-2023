class ImageConverterModel {
  String image;
  String extension;
  Function onTap;
  ImageConverterModel(this.image, this.extension, this.onTap);
}

class ListOfImageModel {
  var listofImageModel = [
    ImageConverterModel("assets/png.png", ".png", () {}),
    ImageConverterModel("assets/jpg.png", ".jpg", () {}),
  ];
}
