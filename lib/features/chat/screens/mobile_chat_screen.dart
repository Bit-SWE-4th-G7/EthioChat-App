import 'package:flutter/material.dart';
import 'package:ethiochat/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ethiochat/features/chat/widgets/chat_list.dart';
import 'package:ethiochat/models/user_model.dart';
import 'package:ethiochat/features/auth/controller/auth_controller.dart';
import 'package:ethiochat/common/widgets/loader.dart';
import 'package:ethiochat/features/chat/widgets/bottom_chat_field.dart';
import 'package:ethiochat/features/chat/widgets/chat_list.dart';

class MobileChatScreen extends ConsumerWidget {
  static const String routeName = '/mobile-chat-screen';
  final String name;
  final String uid;
  final bool isGroupChat;
  final String profilePic;
  const MobileChatScreen({
    Key? key,
    required this.name,
    required this.uid,
    required this.isGroupChat,
    required this.profilePic,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color(0xFF00E4E3),
            Color(0xFFA060FF),
          ])),
        ),
        foregroundColor: Colors.black,
        title: isGroupChat == true
            ? Text(name)
            : StreamBuilder<UserModel>(
                stream: ref.read(authControllerProvider).userDataById(uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Loader();
                  }
                  return Column(
                    children: [
                      Text(name),
                      Text(
                        snapshot.data!.isOnline ? 'online' : 'offline',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  );
                }),
        centerTitle: false,
        actions: [],
      ),
      body: Column(
        children: [
          Expanded(
            child: ChatList(
                recieverUserId: uid, isGroupChat: isGroupChat ?? false),
          ),
          BottomChatField(
              recieverUserId: uid, isGroupChat: isGroupChat ?? false),
        ],
      ),
    );
  }
}
