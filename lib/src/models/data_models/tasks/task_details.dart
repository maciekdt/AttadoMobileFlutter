import 'package:attado_mobile/src/models/data_models/common/history_action.dart';
import 'package:attado_mobile/src/models/data_models/common/related_item.dart';
import 'package:attado_mobile/src/models/data_models/tasks/task_comment.dart';
import 'package:attado_mobile/src/models/data_models/tasks/task_member.dart';

class TaskDetails {
  TaskDetails({
    required this.actions,
    required this.members,
    required this.comments,
    required this.relatedItems,
  });

  List<HistoryAction> actions;
  List<TaskMember> members;
  List<TaskComment> comments;
  List<RelatedItem> relatedItems;

  factory TaskDetails.fromJson(Map<String, dynamic> json) {
    return TaskDetails(
      actions: (json['actions'] as List<dynamic>)
          .map((model) => HistoryAction.fromJson(model))
          .toList(),
      members: (json['members'] as List<dynamic>)
          .map((model) => TaskMember.fromJson(model))
          .toList(),
      comments: (json['comments'] as List<dynamic>)
          .map((model) => TaskComment.fromJson(model))
          .toList(),
      relatedItems: (json['relatedItems'] as List<dynamic>)
          .map((model) => RelatedItem.fromJson(model))
          .toList(),
    );
  }
}
