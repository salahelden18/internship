import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship/core/global/colors.dart';
import 'package:internship/core/utils/get_name_from_email.dart';
import 'package:internship/core/widgets/show_toast.dart';
import 'package:internship/models/chats_model.dart';
import 'package:internship/screens/home/cubit/home_cubit.dart';
import 'package:internship/widgets/small_background_linear_gradient.dart';

import '../../widgets/space_height.dart';

class ChatMessages extends StatefulWidget {
  const ChatMessages({super.key});
  static const String routeName = '/chats-messages-screen';

  @override
  State<ChatMessages> createState() => _ChatMessagesState();
}

class _ChatMessagesState extends State<ChatMessages> {
  String? message;
  final TextEditingController _textEditingController = TextEditingController();
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Scroll to the bottom of the list after the widget is rendered
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatIndex = ModalRoute.of(context)!.settings.arguments as int;
    final chat = context.watch<HomeCubit>().dataModel!.chats.firstWhere(
          (element) => element.id == chatIndex,
        );
    return Scaffold(
      body: Column(
        children: [
          SmallbackgroundLinearGradient(
              text: getNameFromEmail(chat.secondParticipant.username)),
          const SpaceHeight(),
          Expanded(
            child: ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.zero,
                itemCount: chat.messages.length,
                itemBuilder: (context, index) {
                  return BubbleSpecialThree(
                    text: chat.messages[index].content,
                    color: chat.messages[index].sender ==
                            chat.firstParticipant.username
                        ? Colors.grey.shade300
                        : thirdColor,
                    tail: true,
                    isSender: chat.messages[index].sender ==
                            chat.firstParticipant.username
                        ? true
                        : false,
                  );
                }),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            right: 10,
            left: 10,
            top: 10),
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              width: 1.5,
              color: thirdColor,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _textEditingController,
                  onChanged: (value) {
                    setState(() {
                      message = value;
                    });
                  },
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10),
                    hintStyle: TextStyle(fontSize: 18),
                    hintText: 'Type Your Message',
                  ),
                ),
              ),
              IconButton(
                onPressed: message == null || message!.isEmpty
                    ? null
                    : () async {
                        if (message == null || message!.isEmpty) {
                          showToast('Please Enter The Message', Colors.red);
                        } else {
                          await context
                              .read<HomeCubit>()
                              .addMessage(chat.secondParticipant.id, message!);

                          setState(() {
                            message = '';
                            _textEditingController.clear();
                          });

                          _scrollController.animateTo(
                            _scrollController.position.maxScrollExtent,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                          // showToast('Message Send Successfully', Colors.green);

                          // Navigator.pop(context);
                        }
                      },
                icon: Icon(
                  Icons.send,
                  color: message == null || message!.isEmpty
                      ? Colors.grey
                      : thirdColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
