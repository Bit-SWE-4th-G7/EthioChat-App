// import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ethiochat/features/chat/widgets/video_player_item.dart';
import 'package:ethiochat/models/message.dart';
import 'package:flutter/material.dart';

import 'package:ethiochat/common/enums/message_enum.dart';

class DisplayTextImageGIF extends StatelessWidget {
  final String message;
  final MessageEnum type;
  const DisplayTextImageGIF({
    Key? key,
    required this.message,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return type == MessageEnum.text
        ? Text(
            message,
            style: const TextStyle(
              fontSize: 16,
            ),
          )
        : type == MessageEnum.video
            ? VideoPlayerItem(videoUrl: message)
            : CachedNetworkImage(
                imageUrl: message,
              );
  }
}
