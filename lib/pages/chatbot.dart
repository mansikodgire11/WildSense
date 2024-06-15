import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatBotChatScreen extends StatefulWidget {
  const ChatBotChatScreen({Key? key});

  @override
  State<ChatBotChatScreen> createState() => _ChatBotChatScreenState();
}

class _ChatBotChatScreenState extends State<ChatBotChatScreen> {
  ScrollController _chatScrollController = ScrollController();
  TextEditingController _userInput = TextEditingController();

  static const apiKey =
      "AIzaSyD8sD_vsCujU-Hx_oxjDjgPSQoQzbbJvn8";

  final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);

  final List<Message> _messages = [];
  bool _isTyping = false;
  bool _isInChat = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 50), () {
      firstMessage();
    });
  }

  Future<void> firstMessage() async {
    final content = [
      Content.text(
          "Welcome to Wildlife Conservation AI! I'm your virtual assistant, Mr. WildSense. I'm here to assist you with wildlife conservation efforts using artificial intelligence. Whether you're an enthusiast, researcher, or conservationist, I'm here to provide you with information, resources, and assistance. Let's work together to protect and preserve our planet's precious biodiversity. How can I assist you today?")
    ];

    final response = await model.generateContent(content);

    setState(() {
      _messages.insert(0, Message(
          isUser: false, message: response.text ?? "", date: DateTime.now()));
      _isInChat = true; // User is now in the chat session
    });
  }

  Future<void> sendMessage() async {
    final userMessage = _userInput.text;

    setState(() {
      _isTyping = true;
      _isInChat = true; // User is now in the chat session
    });

    final userMessageContent = [Content.text(userMessage)];
    final userResponse = Message(
      isUser: true,
      message: userMessage,
      date: DateTime.now(),
    );

    setState(() {
      _messages.insert(0, userResponse);
    });

    final botResponseContent = await model.generateContent(userMessageContent);

    final botResponse = Message(
      isUser: false,
      message: botResponseContent.text ?? "",
      date: DateTime.now(),
    );

    setState(() {
      _messages.insert(0, botResponse);
      _isTyping = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Handle back button press
        if (_isInChat) {
          setState(() {
            _isInChat = false;
          });
          return false;
        }
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/newbackground.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              children: [
                SizedBox(height: MediaQuery.of(context).padding.top + 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        // If the user is in the chat, pop the screen
                        if (_isInChat) {
                          Navigator.of(context).pop();
                        }
                      },
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      iconSize: 30,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Talk with Mr. WildSense',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    controller: _chatScrollController,
                    reverse: true,
                    shrinkWrap: true,
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final message = _messages[index];
                      return Messages(
                        isUser: message.isUser,
                        message: message.message,
                        date: DateFormat('HH:mm').format(message.date),
                        isTyping: index == 0 && _isTyping,
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 15,
                        child: TextFormField(
                          style: TextStyle(color: Colors.white),
                          controller: _userInput,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Color(0xffffffff)),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            labelText: 'Enter Your Message',
                            labelStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Spacer(),
                      // Only show the send button if not typing
                      if (!_isTyping)
                        IconButton(
                          padding: EdgeInsets.all(12),
                          iconSize: 30,
                          icon: Icon(Icons.send),
                          color: Colors.white,
                          onPressed: () {
                            sendMessage();
                            _userInput.clear();
                          },
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Message {
  final bool isUser;
  final String message;
  final DateTime date;

  Message({required this.isUser, required this.message, required this.date});
}

class Messages extends StatelessWidget {
  final bool isUser;
  final String message;
  final String date;
  final bool isTyping;

  const Messages(
      {Key? key,
        required this.isUser,
        required this.message,
        required this.date,
        required this.isTyping});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(vertical: 15)
          .copyWith(left: isUser ? 100 : 10, right: isUser ? 10 : 100),
      decoration: BoxDecoration(
          color: isUser ? Colors.blueAccent : Colors.grey.shade400,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: isUser ? Radius.circular(10) : Radius.zero,
              topRight: Radius.circular(10),
              bottomRight: isUser ? Radius.zero : Radius.circular(10))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message,
            style: TextStyle(
                fontSize: 16,
                color: isUser ? Colors.white : Colors.black,
                fontFamily: 'SF Pro'),
          ),
          Text(
            date,
            style: TextStyle(
                fontSize: 10,
                color: isUser ? Colors.white : Colors.black,
                fontFamily: 'SF Pro'),
          ),
          if (isTyping)
            Container(
              margin: EdgeInsets.only(left: 40),
              child: Row(
                children: [
                  ThreeDotAnimation(),
                  SizedBox(width: 10),
                  Text(
                    'Mr. WildSense is typing...',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class ThreeDotAnimation extends StatefulWidget {
  const ThreeDotAnimation({Key? key}) : super(key: key);

  @override
  _ThreeDotAnimationState createState() => _ThreeDotAnimationState();
}

class _ThreeDotAnimationState extends State<ThreeDotAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildDot(0),
        SizedBox(width: 5),
        _buildDot(1),
        SizedBox(width: 5),
        _buildDot(2),
      ],
    );
  }

  Widget _buildDot(int index) {
    return FadeTransition(
      opacity: Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            (0.33 * index),
            (0.33 * index) + 0.33,
            curve: Curves.easeInOut,
          ),
        ),
      ),
      child: Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
