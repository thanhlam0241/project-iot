class AttendanceResult {
  final String deviceId;
  final String name;
  final String employeeCode;
  final String time;
  final String status;

  AttendanceResult({
    required this.deviceId,
    required this.name,
    required this.employeeCode,
    required this.time,
    required this.status,
  });

  factory AttendanceResult.fromJson(Map<dynamic, dynamic> json) {
    return AttendanceResult(
      deviceId: json['deviceId'],
      name: json['name'],
      employeeCode: json['employeeCode'],
      time: json['time'],
      status: json['status'],
    );
  }
}