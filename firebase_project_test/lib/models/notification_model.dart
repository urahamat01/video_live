class NotificationsModel {
  dynamic id;
  String? title;
  String? description;
  String? topic;

  NotificationsModel({
    this.id,
    this.title,
    this.description,
    this.topic,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'title': title,
      'message': description,
      'topic': topic,
    };
    return map;
  }

  NotificationsModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    description = map['message'];
    topic = map['topic'];
  }

  String toJson({NotificationsModel? masterViewModel}) {
    String str = '{';
    if (title != null) {
      str += '"title" : "$title",';
    }
    if (description != null) {
      str += '"message" : "$description",';
    }
    if (topic != null) {
      str += '"topic" : "$topic",';
    }
    str += '}';
    return str;
  }

  NotificationsModel.fromJson(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    description = map['message'];
    topic = map['topic'];
  }
}
