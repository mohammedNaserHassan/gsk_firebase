import 'package:flutter/material.dart';
import 'package:gsk_firebase/Providers/Auth_provider.dart';
import 'package:gsk_firebase/Chating/Models/messages_.dart';
import 'package:gsk_firebase/Chating/View/constants.dart';
import 'package:gsk_firebase/Chating/View/status.dart';
import 'package:gsk_firebase/Chating/components/videocontainer.dart';
import 'package:provider/provider.dart';
import 'audiocontainer.dart';
import 'buildContainer.dart';

class messeges extends StatelessWidget {
  messeges();

  Widget messageContainer(ChatMessage chatMessage) {
    switch (chatMessage.messageType) {
      case ChatMessageType.text:
        return buildContainer();
        break;
      case ChatMessageType.audio:
        return audio_container();
        break;
      case ChatMessageType.video:
        return video_container();
        break;
      default:
        return SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, provider, x) => Expanded(
          child: ListView(
              children: demeChatMessages.map((e) {
        provider.setChatMessage(e);
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment:
                e.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              if (!e.isSender)
                Consumer<AuthProvider>(
                  builder: (context, provider, c) => CircleAvatar(
                    radius: 12,
                    backgroundImage: AssetImage(provider.img),
                  ),
                ),
              SizedBox(
                height: kDefaultPadding / 2,
              ),
              messageContainer(e),
              if (e.isSender) statew(e.messageStatus)
            ],
          ),
        );
      }).toList())),
    );
  }
}
