import 'package:isar_community/isar.dart';

part 'ai_chat_message.g.dart';

enum AiChatMessageRole { user, assistant }

enum AiChatMessageActionStatus { none, pending, applying, applied, dismissed, failed }

@Collection(accessor: 'aiChatMessages')
class AiChatMessage {
  AiChatMessage({
    this.id = Isar.autoIncrement,
    required this.conversationId,
    required this.role,
    required this.text,
    required this.createdAt,
    this.actionsJson,
    this.actionStatus = AiChatMessageActionStatus.none,
    this.actionResult,
  });

  Id id;

  @Index()
  int conversationId;

  @enumerated
  late AiChatMessageRole role;

  late String text;

  @Index()
  DateTime createdAt;

  String? actionsJson;

  @enumerated
  AiChatMessageActionStatus actionStatus;

  String? actionResult;
}