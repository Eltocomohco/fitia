import 'package:isar_community/isar.dart';

part 'ai_chat_conversation_log.g.dart';

@Collection(accessor: 'aiChatConversationLogs')
class AiChatConversationLog {
  AiChatConversationLog({
    this.id = Isar.autoIncrement,
    required this.agentKey,
    required this.createdAt,
    required this.transcript,
  });

  Id id;

  @Index()
  late String agentKey;

  @Index()
  late DateTime createdAt;

  late String transcript;
}