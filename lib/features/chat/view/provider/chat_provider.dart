import 'package:quiz_me/main/imports.dart';

class ChatProvider extends ChangeNotifier {
  bool isDispose = false;

  @override
  notifyListeners() {
    if (isDispose) return;
    super.notifyListeners();
  }

  @override
  void dispose() {
    isDispose = true;
    controller.dispose();
    scrollController.dispose();
    super.dispose();
  }

  TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set setIsLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Failure? _failure;
  Failure? get failure => _failure;
  set setFailure(Failure? fail) {
    _failure = fail;
    notifyListeners();
  }

  String? _threadId;
  String? get threadId => _threadId;
  set setThreadId(String? id) {
    _threadId = id;
    notifyListeners();
  }

  List<ChatMessage> _messages = [];
  List<ChatMessage> get messages => _messages;
  set setMessages(ChatMessage message) {
    _messages.add(message);
    _messages = messages;
    notifyListeners();
  }

  Future<void> getResponse(String content) async {
    setIsLoading = true;
    final message = controller.text;
    controller.clear();
    setMessages = ChatMessage(role: 'user', content: message);
    _scrollToBottom();
    String prompt =
        threadId != null ? message : promptFormate(message, content);
    final payload = ChatEntity(
      messages: [
        if (threadId != null)
          ChatMessage(
              role: "system",
              content: "This is a continuation of thread: $threadId")
        else
          ChatMessage(role: "system", content: "You are a QuizMe assistant."),
        ChatMessage(role: "user", content: prompt),
      ],
    );
    ChatRepository repository = ChatRepositoryImpl();
    final failOrResult = await GetChat(repository).generate(payload: payload);
    failOrResult.fold(
      (fail) {
        setIsLoading = false;
        setMessages = ChatMessage(role: 'system', content: fail.errorMessage);
        _scrollToBottom();
      },
      (result) {
        setIsLoading = false;
        setThreadId = result['id'];
        setMessages = ChatMessage(role: 'system', content: result['content']);
        _scrollToBottom();
      },
    );
  }

  String promptFormate(String message, String content) {
    return '''
You are QuizMe Assistant, a friendly and helpful assistant. Always provide well-structured, complete, and helpful answers. Ensure your responses are accurate, concise, and free of unnecessary symbols or markdown artifacts. If you don’t know the answer, clearly state so. Respond strictly in the language specified by the user. Avoid including any content in other languages unless explicitly requested.

Here is your task:
1. Ensure answers are complete,must be strick to the content ($content), well-structured, and helpful. Avoid leaving sentences incomplete. 
2. If you are unsure, state that clearly instead of guessing.
3. Do not include any unnecessary symbols, markdown artifacts, or content in a different language.
4. Conclude your response with a summary sentence wrapping up your main points.

User Query:
$message
''';
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }
}
