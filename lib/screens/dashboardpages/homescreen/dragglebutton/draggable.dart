import 'package:flutter/material.dart';

import '../../../../pages/chatbot.dart';

class DraggableFab extends StatefulWidget {
  @override
  _DraggableFabState createState() => _DraggableFabState();
}

class _DraggableFabState extends State<DraggableFab> {
  late Offset position;

  @override
  void initState() {
    super.initState();
    position = const Offset(330, 780); // Initial position of the button
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: position.dx,
          top: position.dy,
          child: GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                position += details.delta;
              });
            },
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatBotChatScreen()),
                );
              },
              child: Icon(Icons.chat),
            ),
          ),
        ),
      ],
    );
  }
}
