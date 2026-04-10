import 'package:isar_community/isar.dart';

part 'ai_chat_conversation.g.dart';

@Collection(accessor: 'aiChatConversations')
class AiChatConversation {
  AiChatConversation({
    this.id = 1,
    this.title = 'Fiti',
    required this.createdAt,
    required this.updatedAt,
  });

  Id id;

  @Index()
  DateTime createdAt;

  @Index()
  DateTime updatedAt;

  String title;
}