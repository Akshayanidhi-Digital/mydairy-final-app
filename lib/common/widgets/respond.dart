class Respond {
  late bool success;
  late String? message;
  dynamic data;
  Respond({required this.success, this.message, this.data});

  Respond.fromJson(Map<String, dynamic> json) {
    success = json['success'] ?? false;
    message = json['message'] ?? '';
    data = json['data'];
  }
}
