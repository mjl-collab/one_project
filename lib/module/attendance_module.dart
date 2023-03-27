class Attendance {
  String id;
  String date;
  String dayName;
  String startTime;
  String? imgStart;
  String? endTime;
  String? imgEnd;
  String currentLocationAddressStart;
  String currentLocationCoords;
  String? currentLocationAddressEnd;
  String? currentLocationCoordsEnd;
  bool isActive;
  bool isSynced;

  Attendance({
    required this.id,
    required this.date,
    required this.dayName,
    required this.startTime,
    this.imgStart,
    this.endTime,
    this.imgEnd,
    required this.currentLocationAddressStart,
    required this.currentLocationCoords,
    this.currentLocationAddressEnd,
    this.currentLocationCoordsEnd,
    required this.isActive,
    required this.isSynced,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) => Attendance(
        id: json["id"],
        date: json["date"],
        dayName: json["dayName"],
        startTime: json["startTime"],
        imgStart: json["imgStart"],
        endTime: json["endTime"],
        imgEnd: json["imgEnd"],
        currentLocationAddressStart: json["currentLocationAddressStart"],
        currentLocationCoords: json["currentLocationCoords"],
        currentLocationAddressEnd: json["currentLocationAddressEnd"],
        currentLocationCoordsEnd: json["currentLocationCoordsEnd"],
        isActive: json["isActive"] == 0 ? false : true,
        isSynced: json["isSynced"] == 0 ? false : true,
      );

  // Convert an Attendance object to a JSON map.
  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date,
        "dayName": dayName,
        "startTime": startTime,
        "imgStart": imgStart,
        "endTime": endTime,
        "imgEnd": imgEnd,
        "currentLocationAddressStart": currentLocationAddressStart,
        "currentLocationCoords": currentLocationCoords,
        "currentLocationAddressEnd": currentLocationAddressEnd,
        "currentLocationCoordsEnd": currentLocationCoordsEnd,
        "isSynced": isSynced ? 1 : 0,
        "isActive": isActive ? 1 : 0,
      };
}
