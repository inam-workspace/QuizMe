import 'package:quiz_me/main/imports.dart';

class FaqsScreen extends StatelessWidget {
  const FaqsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> faqs = [
      {
        "question": "What is QuizMe?",
        "answer":
            "QuizMe is a smart learning app designed for students to enhance their study experience by generating quizzes, mock tests, flashcards, and notes from their study guides (PDF, PNG, JPG, TXT, DOC, and YouTube links). It also provides AI-powered assistance for clearing doubts and analyzing progress."
      },
      {
        "question": "What features does QuizMe offer?",
        "answer": """
- **Generate Quizzes**: Create tailored quizzes based on your uploaded study guide.
- **Mock Tests**: Simulate exams covering the entire guide to assess readiness.
- **Flashcards**: Enhance retention by generating flashcards from study materials.
- **Note Generation**: Create summarized notes for easy revision.
- **AI Assistance**: Chat with AI for explanations or to clear confusions in your notes.
- **Progress Tracking**: Keep a record of your quiz and mock test results.
"""
      },
      {
        "question": "What formats are supported for study guides?",
        "answer": """
QuizMe supports the following formats:
- PDF
- PNG
- JPG
- TXT
- DOC
- YouTube links
"""
      },
      {
        "question": "Is QuizMe free to use?",
        "answer": """
QuizMe is a premium app offering two subscription plans:
- **Weekly Plan**: Short-term access for intensive preparation.
- **Yearly Plan**: Long-term access for continuous learning and revision.
"""
      },
      {
        "question": "How does QuizMe help in tracking progress?",
        "answer":
            "QuizMe stores your quiz and mock test results in your user account. This allows you to analyze performance trends and identify areas for improvement."
      },
      {
        "question": "Can I access QuizMe on multiple devices?",
        "answer":
            "Yes, QuizMe supports multi-device access. Ensure you log in using your registered credentials."
      },
      {
        "question": "How does the AI assistant work?",
        "answer": """
The AI assistant is designed to:
- Answer questions based on your uploaded study materials.
- Provide explanations for concepts or notes.
- Clarify doubts and help with difficult topics.
"""
      },
      {
        "question": "How is user data protected?",
        "answer":
            "QuizMe prioritizes your privacy. It uses secure authentication methods and encrypts all stored data, including quiz results and personal information."
      },
      {
        "question": "What are the payment options for subscriptions?",
        "answer": """
Subscriptions can be purchased using:
- Credit/Debit cards
- Online payment gateways
- Other region-specific options based on availability
"""
      },
      {
        "question": "Can I cancel my subscription?",
        "answer":
            "Yes, subscriptions can be canceled anytime. However, features will remain active until the end of your current billing period."
      },
      {
        "question": "Are there any discounts for long-term plans?",
        "answer":
            "Yes, the yearly plan offers a significant discount compared to the weekly plan, making it the most cost-effective choice for long-term users."
      },
      {
        "question": "Who can benefit from QuizMe?",
        "answer": """
QuizMe is ideal for:
- Students preparing for exams.
- Individuals seeking to improve retention with flashcards.
- Anyone looking to summarize or organize study materials effectively.
"""
      },
      {
        "question": "How do I get started with QuizMe?",
        "answer": """
1. Download QuizMe from your app store.
2. Sign up and choose a subscription plan.
3. Upload your study guide and start exploring features like quizzes, flashcards, and AI assistance.
"""
      },
    ];

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
          "FAQ's",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: ListView.builder(
        itemCount: faqs.length,
        itemBuilder: (context, index) {
          return ExpansionTile(
            expandedAlignment: Alignment.centerLeft,
            childrenPadding: gapSymmetric(horizontal: 12),
            title: Text(
              faqs[index]['question']!,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            collapsedIconColor: Theme.of(context).colorScheme.scrim,
            iconColor: Theme.of(context).colorScheme.scrim,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MarkdownBody(
                  data: faqs[index]['answer']!,
                  styleSheet: MarkdownStyleSheet(
                    p: Theme.of(context).textTheme.bodyMedium,
                    strong: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    listBullet: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
