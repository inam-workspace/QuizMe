import 'package:quiz_me/main/imports.dart';

class ChatScreenArguments {
  final ChapterDetailsEntity topic;
  ChatScreenArguments({required this.topic});
}

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        width: w(1),
        color: Theme.of(context).hintColor,
      ),
    );
    final args =
        ModalRoute.of(context)!.settings.arguments! as ChatScreenArguments;
    return ChangeNotifierProvider(
      create: (context) => ChatProvider(),
      builder: (context, child) {
        return Consumer<ChatProvider>(
          builder: (context, provider, child) {
            return Scaffold(
              appBar: AppBar(
                forceMaterialTransparency: true,
                leading: IconButton(
                  onPressed: () {
                    Push.back();
                  },
                  icon: SvgPicture.asset(
                    'assets/icons/back.svg',
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.scrim,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                centerTitle: true,
                title: Text(
                  args.topic.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              body: ListView.builder(
                shrinkWrap: true,
                controller: provider.scrollController,
                padding: gapOnly(bottom: h(70)),
                physics: BouncingScrollPhysics(),
                itemCount: provider.messages.length,
                itemBuilder: (context, index) {
                  return ChatBubble(
                    message: provider.messages[index],
                  );
                },
              ),
              bottomSheet: Padding(
                padding: gapAll(10.0),
                child: Row(
                  children: [
                    Flexible(
                      child: TextFormField(
                        controller: provider.controller,
                        cursorColor: Theme.of(context).primaryColor,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        style: Theme.of(context).textTheme.bodyMedium,
                        decoration: InputDecoration(
                          isDense: true,
                          filled: true,
                          hintText: 'Type here...',
                          hintStyle: Theme.of(context).textTheme.labelLarge,
                          fillColor: Theme.of(context).scaffoldBackgroundColor,
                          border: border,
                          enabledBorder: border,
                          focusedBorder: border,
                        ),
                      ),
                    ),
                    SizedBox(width: w(10)),
                    CustomButton(
                      width: w(45),
                      height: w(45),
                      borderRadius: 10,
                      backgroundColor: Theme.of(context).primaryColor,
                      widget: provider.isLoading
                          ? Padding(
                              padding: gapAll(12.0),
                              child: CircularProgressIndicator(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                strokeWidth: w(3),
                              ),
                            )
                          : SvgPicture.asset(
                              'assets/icons/send.svg',
                              colorFilter: ColorFilter.mode(
                                Theme.of(context).scaffoldBackgroundColor,
                                BlendMode.srcIn,
                              ),
                            ),
                      onPressed: provider.isLoading
                          ? () {}
                          : () {
                              provider.getResponse(args.topic.content);
                            },
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
