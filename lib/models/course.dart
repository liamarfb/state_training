class Course {
  final String title;
  final String code;
  final int sks;
  final String desc;

  Course({
    required this.title,
    required this.code,
    required this.sks,
    required this.desc,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      title: json['title'],
      code: json['code'],
      sks: json['sks'],
      desc: json['desc'],
    );
  }
}