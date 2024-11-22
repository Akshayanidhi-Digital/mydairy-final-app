class NotificationModel {
  NotificationModel({
    this.id,
    this.userId,
    this.message,
    this.isMarked,
    this.messageType,
    this.recordId,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final String? userId;
  final String? message;
  final int? isMarked;
  final int? messageType;
  final dynamic recordId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json["id"] ?? 0,
      userId: json["user_id"] ?? "",
      message: json["message"] ?? "",
      isMarked: json["is_marked"] ?? 0,
      messageType: json["message_type"] ?? 0,
      recordId: json["record_id"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

  @override
  String toString() {
    return "$id, $userId, $message, $isMarked, $messageType, $recordId, $createdAt, $updatedAt, ";
  }
}
