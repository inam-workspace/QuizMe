import 'package:quiz_me/main/imports.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessage message;
  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.role == 'system'
          ? Alignment.centerLeft
          : Alignment.centerRight,
      child: Container(
        margin: gapSymmetric(horizontal: 10, vertical: 5),
        padding: gapAll(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: message.role == 'system'
              ? Theme.of(context).primaryColor.withOpacity(0.15)
              : Theme.of(context).hintColor.withOpacity(0.15),
        ),
        constraints: BoxConstraints(
          maxWidth: screenWidth * 0.75,
        ),
        child: Text(message.content),
      ),
    );
  }
}
