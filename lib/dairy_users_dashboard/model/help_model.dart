class HelpModel {
  String? name;
  String? image;
  String? url;
  String? imagePath;

  HelpModel({this.name, this.image, this.url, this.imagePath});

  HelpModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    url = json['url'];
    imagePath = json['image_path'];
  }

}
