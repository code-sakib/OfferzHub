// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:offerzhub/core/globals.dart';
import 'package:offerzhub/features/auth/auth_ui.dart';
import 'package:offerzhub/features/chat/data/chat_service.dart';
import 'package:offerzhub/features/offers/domain/offers_model.dart';
import 'package:offerzhub/utlis/get_time.dart';
import 'package:offerzhub/utlis/snackbar.dart';

class ChatScreen extends StatefulWidget {
  final UserModel user;
  const ChatScreen({
    super.key,
    required this.user,
  });

  static final _chatService = ChatService();

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  //text field FocusNode
  final FocusNode myfocusNode = FocusNode();
  static final TextEditingController _messageController =
      TextEditingController();
  ValueNotifier<bool> showTyping = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    setCurrentStatus('online');
    myfocusNode.addListener(() {
      if (myfocusNode.hasFocus) {
        //will wait for keyboard then built in remaining space
        Future.delayed(const Duration(milliseconds: 500), () => scrollDown());
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    myfocusNode.dispose();
    setCurrentStatus('offline');
  }

  //setCurrentStatus
  void setCurrentStatus(String currentStatus) async {
    await ChatScreen._chatService
        .sendImpFields(currentUser.uid, widget.user.uID, currentStatus);
  }

  //Scrolling
  ScrollController scrollController = ScrollController();
  void scrollDown() {
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn);
  }

  //onTap sendButton
  void sendMessage() async {
    //check if input is empty
    if (_messageController.text.isEmpty) return;
    //send message
    await ChatScreen._chatService.sendMessages(
        currentUser.uid, widget.user.uID, _messageController.text);

    //clear TextField
    _messageController.clear();
    scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
            )),
        titleSpacing: -1,
        title: Row(
          children: [
            CircleAvatar(
                radius: 20,
                backgroundImage: widget.user.dp != null
                    ? NetworkImage(
                        widget.user.dp!,
                      )
                    : null,
                child: widget.user.dp == null
                    ? Text(widget.user.name[0].toUpperCase())
                    : null),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.user.name),
                _getUserStatusWidget(widget.user, showTyping) ?? Text('data')
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.gpp_maybe_outlined,
                size: 25,
              ))
        ],
        foregroundColor: Colors.grey,
        forceMaterialTransparency: true,
      ),
      body: Column(
        children: [
          //mainly displaying messages
          Expanded(child: _buildMessageList()),

          //typingStatus
          ValueListenableBuilder(
            valueListenable: showTyping,
            builder: (context, value, child) {
              return value ? _typingBubble() : Container();
            },
          ),

          //user text input
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(30)),
              child: Row(
                children: [
                  Flexible(
                    child: TextField(
                      focusNode: myfocusNode,
                      style: const TextStyle(color: Colors.white),
                      controller: _messageController,
                      textCapitalization: TextCapitalization.sentences,
                      onChanged: (value) {
                        if (_messageController.text.isNotEmpty) {
                          setCurrentStatus('typing..');
                          scrollDown();
                        } else {
                          showTyping.value = false;
                          setCurrentStatus('online');
                        }
                      },
                      onEditingComplete: () {
                        sendMessage();
                      },
                      decoration: const InputDecoration(
                        hintText: 'Message...',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  FloatingActionButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    onPressed: () => sendMessage(),
                    backgroundColor: Colors.deepPurple,
                    child: const Icon(
                      Icons.send_rounded,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
        stream: ChatScreen._chatService
            .getMessages(currentUser.uid, widget.user.uID),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            AppSnackBar.showSnackBar(snapshot.error, colorGreen: false);
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const CupertinoActivityIndicator();
          }
          if (snapshot.hasData) {
            Future.delayed(
                const Duration(
                  milliseconds: 500,
                ),
                () => scrollDown());
          }
          return ListView(
            controller: scrollController,
            shrinkWrap: true,
            children: snapshot.data!.docs
                .map((doc) => _builtMessageItem(doc))
                .toList(),
          );
        });
  }

  //build message item
  Widget _builtMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final bool isCurrentUser = data['senderId'] == currentUser.uid;
    Alignment alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    // final time = DateTime(data['timestamp']).hour.toString();

    return Container(
        alignment: alignment,
        child: chatBubble(
            data['message'], getTime(data['timestamp']), isCurrentUser));
  }
}

Widget chatBubble(String message, String time, bool isCurrentUser) {
  return Container(
      margin: EdgeInsets.only(
        left: isCurrentUser ? 64 : 8,
        right: isCurrentUser ? 8 : 64,
        bottom: 8,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: isCurrentUser ? Colors.deepPurple : Colors.grey.shade900,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(20),
          topRight: const Radius.circular(20),
          bottomLeft: Radius.circular(isCurrentUser ? 20 : 0),
          bottomRight: Radius.circular(isCurrentUser ? 0 : 20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            time,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 12,
            ),
          ),
        ],
      ));
}

//getting whether user is online offline or typing
StreamBuilder? _getUserStatusWidget(
    UserModel otherUser, ValueNotifier showTyping) {
  return StreamBuilder(
    stream: ChatScreen._chatService
        .getCurrentStatus(currentUser.uid, otherUser.uID),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.active &&
          snapshot.hasData) {
        String text;
        try {
          text = snapshot.data.get("usersCurrentStatus.${otherUser.uID}");
        } catch (e) {
          text = 'offline';
        }

        switch (text) {
          case 'online':
            return Text(
              text,
              style: const TextStyle(fontSize: 10, color: Colors.green),
            );
          case 'typing..':
            WidgetsBinding.instance
                .addPostFrameCallback((timeStamp) => showTyping.value = true);
            return const Text(
              'online',
              style: TextStyle(fontSize: 10, color: Colors.green),
            );
        }
      } else if (snapshot.connectionState == ConnectionState.waiting) {
        const Text(
          'loading',
          style: TextStyle(fontSize: 10, color: Colors.grey),
        );
      }
      return const Text(
        'offline',
        style: TextStyle(fontSize: 10, color: Colors.grey),
      );
    },
  );
}

Widget _typingBubble() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(20),
          ),
        ),
        width: 60,
        height: 50,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.0),
          child: AnimatedTextKit(repeatForever: true, animatedTexts: [
            TyperAnimatedText('  ...',
                textStyle: const TextStyle(color: Colors.white, fontSize: 28),
                speed: const Duration(milliseconds: 200))
          ]),
        ),
      ),
    ),
  );
}

class GuestChatScreen extends StatelessWidget {
  const GuestChatScreen({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) =>
        AppSnackBar.showSnackBar(
            'Login to message, so that we can store your chats',
            colorGreen: false));
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
              )),
          titleSpacing: -1,
          title: Row(
            children: [
              CircleAvatar(
                  radius: 20,
                  backgroundImage: user.dp != null
                      ? NetworkImage(
                          user.dp!,
                        )
                      : null,
                  child: user.dp == null
                      ? Text(user.name[0].toUpperCase())
                      : null),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.name),
                  const Text(
                    'offline',
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  )
                ],
              ),
            ],
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.gpp_maybe_outlined,
                  size: 25,
                ))
          ],
          foregroundColor: Colors.grey,
          forceMaterialTransparency: true,
        ),
        body: Stack(
          children: [
            Center(
              child: OutlinedButton(
                  onPressed: () {
                    context.goNamed('auth');
                    isGuest = false;
                  },
                  child: const Text(
                    'Go to login',
                    style: TextStyle(fontSize: 15),
                  )),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(30)),
                  child: Row(
                    children: [
                      const Flexible(
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          textCapitalization: TextCapitalization.sentences,
                          decoration: InputDecoration(
                            hintText: 'Message...',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      FloatingActionButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        onPressed: () {
                          AppSnackBar.showSnackBar(
                              'Login to message, so that we can store your chats',
                              colorGreen: false);
                        },
                        backgroundColor: Colors.deepPurple,
                        child: const Icon(
                          Icons.send_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
