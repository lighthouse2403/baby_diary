
import 'package:baby_diary/common/extension/date_time_extension.dart';
import 'package:baby_diary/common/extension/string_extension.dart';

class Diary {
  String diaryId = '${DateTime.now().microsecondsSinceEpoch}';
  String title = '';
  String content = '';
  DateTime time = DateTime.now();
  DateTime createdTime = DateTime.now();
  DateTime updatedTime = DateTime.now();
  List<String> mediaUrl = [];

  Diary({
    required this.diaryId,
    required this.title,
    required this.content,
    required this.time,
    required this.createdTime,
    required this.updatedTime,
    required this.mediaUrl,
  });

  Diary.init() {
    diaryId = '${DateTime.now().microsecondsSinceEpoch}';
    title = '';
    content = '';
    time = DateTime.now();
    createdTime = DateTime.now();
    updatedTime = DateTime.now();
    mediaUrl = [];
  }

  Diary.fromDatabase(Map<String, dynamic> json) {
    diaryId = json['diaryId'];
    title = json['title'];
    content = json['content'];
    time = DateTime.fromMicrosecondsSinceEpoch(json['time'] as int);
    createdTime = DateTime.fromMicrosecondsSinceEpoch(json['createdTime'] as int);
    updatedTime = DateTime.fromMicrosecondsSinceEpoch(json['updatedTime'] as int);

    String mediaURL = json['mediaUrl'] ?? '';
    if (mediaURL.isEmpty) {
      return;
    }

    if (mediaURL.contains('--')) {
      mediaUrl = json['mediaUrl'].split('--');
    } else {
      mediaUrl = [json['mediaUrl']];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['diaryId'] = diaryId;
    data['title'] = title;
    data['content'] = content;
    data['time'] = time.microsecondsSinceEpoch;
    data['createdTime'] = createdTime.microsecondsSinceEpoch;
    data['updatedTime'] = updatedTime.microsecondsSinceEpoch;
    String media = mediaUrl.firstOrNull ?? '';

    if (mediaUrl.length > 1) {
      media = mediaUrl.join('--');
    }
    data['mediaUrl'] = media;
    return data;
  }
}