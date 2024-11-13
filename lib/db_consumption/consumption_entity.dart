class ConsumptionEntity {
  int id;
  DateTime createdTime;
  String amount;
  String remark;
  int star;

  ConsumptionEntity({
    required this.id,
    required this.createdTime,
    required this.amount,
    required this.remark,
    required this.star,
  });

  factory ConsumptionEntity.fromJson(Map<String, dynamic> json) {
    return ConsumptionEntity(
      id: json['id'],
      createdTime: DateTime.parse(json['createdTime']),
      amount: json['amount'],
      remark: json['remark'],
      star: json['star'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdTime': createdTime.toIso8601String(),
      'amount': amount,
      'remark': remark,
      'star': star,
    };
  }

  String get timeTransString {
    var result = '';
    final now = DateTime.now();
    if (now.year == createdTime.year &&
        now.month == createdTime.month &&
        now.day == createdTime.day) {
      final diff = now.difference(createdTime);
      if (diff.inHours > 0) {
        result = '${diff.inHours} hours ago';
      } else {
        if (diff.inMinutes > 0) {
          result = '${diff.inMinutes} minutes ago';
        } else {
          result = 'Just now';
        }
      }
    } else {
      final diff = now.difference(createdTime);
      result = '${diff.inDays} days ago';
    }
    return result;
  }
}
