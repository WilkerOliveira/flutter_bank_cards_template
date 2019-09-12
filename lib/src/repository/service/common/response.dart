abstract class Response {
  bool success = true;
  String code;
  String description;

  Response error;
  Map<String, dynamic> data;

  void fromErrorJson(Map<String, dynamic> json) {
    success = false;
    code = json['code'];
    description = json['description'];
  }
}
