class PrayerTime {
  final String name;
  final String time;
  final bool isActive;

  PrayerTime({required this.name, required this.time, this.isActive = false});

  factory PrayerTime.fromJson(Map<String, dynamic> json) {
    return PrayerTime(
      name: json['name'] as String,
      time: json['time'] as String,
      isActive: json['isActive'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'time': time, 'isActive': isActive};
  }

  PrayerTime copyWith({String? name, String? time, bool? isActive}) {
    return PrayerTime(
      name: name ?? this.name,
      time: time ?? this.time,
      isActive: isActive ?? this.isActive,
    );
  }
}
