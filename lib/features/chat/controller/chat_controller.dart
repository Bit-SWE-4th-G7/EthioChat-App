import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ethiochat/common/enums/message_enum.dart';
import 'package:ethiochat/features/auth/controller/auth_controller.dart';
import 'package:ethiochat/features/chat/repositories/chat_repository.dart';
import 'package:ethiochat/models/chat_contact.dart';
import 'package:ethiochat/models/message.dart';
import 'package:ethiochat/models/group.dart';

final chatControllerProvider = Provider((ref) {
  final chatRepository = ref.watch(chatRepositoryProvider);
  return ChatController(
    chatRepository: chatRepository,
    ref: ref,
  );
});

class ChatController {
  final ChatRepository chatRepository;
  final ProviderRef ref;
  ChatController({
    required this.chatRepository,
    required this.ref,
  });
  Stream<List<ChatContact>> chatContacts() {
    return chatRepository.getChatContacts();
  }

  Stream<List<Group>> chatGroups() {
    return chatRepository.getChatGroups();
  }

  Stream<List<Message>> groupChatStream(String groupId) {
    return chatRepository.getGroupChatStream(groupId);
  }

  Stream<List<Message>> chatStream(String recieverUserId) {
    return chatRepository.getChatStream(recieverUserId);
  }

  void sendTextMessage(
    BuildContext context,
    String text,
    String recieverUserId,
    bool isGroupChat,
  ) {
    ref.read(userDataAuthProvider).whenData(
          (value) => chatRepository.sendTextMessage(
              context: context,
              text: text,
              recieverUserId: recieverUserId,
              senderUser: value!,
              isGroupChat: isGroupChat ?? false),
        );
  }

  void sendFileMessage(
    BuildContext context,
    File file,
    String recieverUserId,
    MessageEnum messageEnum,
    bool isGroupChat,
  ) {
    ref.read(userDataAuthProvider).whenData(
          (value) => chatRepository.sendFileMessage(
              context: context,
              file: file,
              recieverUserId: recieverUserId,
              senderUserData: value!,
              messageEnum: messageEnum,
              ref: ref,
              isGroupChat: isGroupChat ?? false),
        );
  }
  void setChatMessageSeen(
    BuildContext context,
    String recieverUserId,
    String messageId,
  ) {
    chatRepository.setChatMessageSeen(
      context,
      recieverUserId,
      messageId,
    );
  }
}
