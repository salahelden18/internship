import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship/core/global/colors.dart';
import 'package:internship/core/utils/get_name_from_email.dart';
import 'package:internship/screens/home/cubit/home_cubit.dart';
import 'package:internship/screens/messages/add_message.dart';
import 'package:internship/screens/messages/chat_messages.dart';
import 'package:internship/screens/messages/widgets/message_item.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../widgets/empty_widget.dart';
import '../../widgets/small_background_linear_gradient.dart';
import '../../widgets/space_height.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  static const String routeName = '/messages-screen';

  @override
  Widget build(BuildContext context) {
    final chats = context.watch<HomeCubit>().dataModel?.chats;
    return Scaffold(
      body: Column(
        children: [
          const SmallbackgroundLinearGradient(text: 'All Messages'),
          const SpaceHeight(),
          chats!.isEmpty
              ? const Padding(
                  padding: EdgeInsets.all(10.0),
                  child:
                      EmptyWidget(text: 'No Messages', imgName: 'message.png'),
                )
              : Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: chats.length,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(ChatMessages.routeName,
                            arguments: chats[index].id);
                      },
                      child: MessageItem(
                        name: getNameFromEmail(
                            chats[index].secondParticipant.username),
                        email: chats[index].secondParticipant.username,
                        date: formatTimestamp(chats[index]
                            .messages[chats[index].messages.length - 1]
                            .date),
                        icon: 'message.png',
                      ),
                    ),
                  ),
                ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: thirdColor,
        onPressed: () {
          Navigator.of(context).pushNamed(AddMessageScreen.routeName);
        },
        child: const Icon(
          Icons.add_comment_outlined,
          size: 28,
        ),
      ),
    );
  }

  String formatTimestamp(String timestamp) {
    final parsedTimestamp = DateTime.parse(timestamp);
    final now = DateTime.now();
    final difference = now.difference(parsedTimestamp);
    return timeago.format(now.subtract(difference));
  }
}
