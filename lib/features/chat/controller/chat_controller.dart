import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ethiochat/common/enums/message_enum.dart';
import 'package:ethiochat/features/auth/controller/auth_controller.dart';
import 'package:ethiochat/features/chat/repositories/chat_repository.dart';
import 'package:ethiochat/models/chat_contact.dart';
import 'package:ethiochat/models/message.dart';

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

  void sendTextMessage(
    BuildContext context,
    String text,
    String recieverUserId,
  ) {
    ref.read(userDataAuthProvider).whenData(
          (value) => chatRepository.sendTextMessage(
            context: context,
            text: text,
            recieverUserId: recieverUserId,
            senderUser: value!,
          ),
        );
  }
}