import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:quiz_me/core/global/widgets/success_dialog.dart';
import 'package:quiz_me/main/imports.dart';

enum ChapterType { link, media, notes }

class IconModel {
  String iconPath;
  Color iconColor;
  bool selected;

  IconModel({
    required this.iconColor,
    required this.iconPath,
    required this.selected,
  });
}

class ChapterModel {
  TextEditingController controller;
  ChapterType type;
  dynamic content;

  ChapterModel({
    required this.content,
    required this.controller,
    required this.type,
  });
}

class AddGuideProvider extends ChangeNotifier {
  final drawerController = AdvancedDrawerController();
  GuideDetailsRepo repository = GuideDetailsRepoImpl();
  final guideNameController = TextEditingController();
  final searchController = TextEditingController();

  Failure? _failure;
  Failure? get failure => _failure;
  set setFailure(Failure? fail) {
    _failure = fail;
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;
  set setLoading(bool status) {
    _loading = status;
    notifyListeners();
  }

  List<GuideDetailsEntity> _guideList = [];
  List<GuideDetailsEntity> get guideList => _guideList;
  set setGuideList(List<GuideDetailsEntity> value) {
    _guideList = value;
    notifyListeners();
  }

  List<GuideDetailsEntity> _unfilterGuideList = [];
  List<GuideDetailsEntity> get unfilterGuideList => _unfilterGuideList;
  set setUnfilterGuideList(List<GuideDetailsEntity> value) {
    _unfilterGuideList = value;
    notifyListeners();
  }

  List<GuideDetailsEntity> get filterGuideList {
    return guideList
        .where((element) => element.guideTitle
            .toLowerCase()
            .contains(searchController.text.toLowerCase()))
        .toList();
  }

  final pageController = PageController(initialPage: 0);
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  set setCurrentIndex(int index) {
    pageController.jumpToPage(index);
    _currentIndex = index;
    notifyListeners();
  }

  AddGuideProvider() {
    searchController.addListener(() {
      if (searchController.text.isEmpty) {
        setGuideList = unfilterGuideList;
      } else {
        setGuideList = filterGuideList;
      }
    });
    get();
  }

  @override
  void dispose() {
    reset();
    super.dispose();
  }

  initilize(GuideDetailsEntity guideDetails) {
    guideNameController.text = guideDetails.guideTitle;
    List<ChapterModel> list = [];
    for (var element in guideDetails.chaptersDetail) {
      list.add(
        ChapterModel(
          content: element.content,
          type: ChapterType.notes,
          controller: TextEditingController(text: element.title),
        ),
      );
    }
    chapters = list;
  }

  next(index) {
    pageController.jumpToPage(index);
  }

  List<IconModel> icons = [
    IconModel(
      iconColor: Color(0xFFFF2C79),
      iconPath: 'assets/icons/icon1.svg',
      selected: true,
    ),
    IconModel(
      iconColor: Color(0xFF7FC665),
      iconPath: 'assets/icons/icon2.svg',
      selected: false,
    ),
    IconModel(
      iconColor: Color(0xFFFE8B57),
      iconPath: 'assets/icons/icon3.svg',
      selected: false,
    ),
    IconModel(
      iconColor: Color(0xFF4FABFD),
      iconPath: 'assets/icons/icon4.svg',
      selected: false,
    ),
    IconModel(
      iconColor: Color(0xFFFF2C79),
      iconPath: 'assets/icons/icon5.svg',
      selected: false,
    ),
    IconModel(
      iconColor: Color(0xFF7FC665),
      iconPath: 'assets/icons/icon6.svg',
      selected: false,
    ),
    IconModel(
      iconColor: Color(0xFFFE8B57),
      iconPath: 'assets/icons/icon7.svg',
      selected: false,
    ),
    IconModel(
      iconColor: Color(0xFF4FABFD),
      iconPath: 'assets/icons/icon8.svg',
      selected: false,
    ),
    IconModel(
      iconColor: Color(0xFFFF2C79),
      iconPath: 'assets/icons/icon9.svg',
      selected: false,
    ),
    IconModel(
      iconColor: Color(0xFF7FC665),
      iconPath: 'assets/icons/icon10.svg',
      selected: false,
    ),
    IconModel(
      iconColor: Color(0xFFFE8B57),
      iconPath: 'assets/icons/icon11.svg',
      selected: false,
    ),
    IconModel(
      iconColor: Color(0xFF4FABFD),
      iconPath: 'assets/icons/icon12.svg',
      selected: false,
    ),
  ];

  changeIconSelection(IconModel iconModel) {
    for (var element in icons) {
      element.selected = false;
    }
    iconModel.selected = true;
    notifyListeners();
  }

  contentChange(ChapterModel chapter, String data) {
    chapter.content = data;
    notifyListeners();
  }

  List<ChapterModel> chapters = [
    ChapterModel(
      content: '',
      type: ChapterType.media,
      controller: TextEditingController(),
    ),
  ];

  addChapter() {
    chapters.add(
      ChapterModel(
        content: '',
        type: ChapterType.media,
        controller: TextEditingController(),
      ),
    );
    notifyListeners();
  }

  reset() {
    setCurrentIndex = 0;
    chapters = [
      ChapterModel(
        content: '',
        type: ChapterType.media,
        controller: TextEditingController(),
      ),
    ];
    guideNameController.clear();
    notifyListeners();
  }

  removerChapter(index) {
    chapters.removeAt(index);
    notifyListeners();
  }

  toggleType(ChapterModel chapter, ChapterType type) {
    chapter.type = type;
    chapter.content = '';
    notifyListeners();
  }

  processGuideDetails() async {
    final uid = AppController.instance.currentUser!.uid;
    showProcessingDialog();
    List<ChapterDetailsEntity> chaptersDetail = [];
    for (var chapter in chapters) {
      chaptersDetail.add(
        ChapterDetailsEntity(
          id: uniqueID,
          content: await preProcessContent(chapter) ?? chapter.content,
          title: chapter.controller.text,
        ),
      );
    }
    final iconDetails = icons.firstWhere((e) => e.selected == true);
    final payload = GuideDetailsEntity(
      authId: uid,
      guideTitle: guideNameController.text,
      chaptersDetail: chaptersDetail,
      iconDetails: IconDetailsEntity(
        iconColor: iconDetails.iconColor.value.toRadixString(16).toUpperCase(),
        iconPath: iconDetails.iconPath,
      ),
      dateTime: DateTime.now().millisecondsSinceEpoch,
      quizPercentage: 0.0,
      quizAttempts: 0,
      mockPercentage: 0.0,
      mockAttempts: 0,
      overallPercentage: 0.0,
    );
    add(payload);
    reset();
  }

  get() async {
    final uid = AppController.instance.authDetails.uid!;
    setLoading = true;
    final failureOrResult = await GetGuideDetails(repository).get(id: uid);
    failureOrResult.fold((fail) {
      setFailure = fail;
      setLoading = false;
    }, (result) {
      List<GuideDetailsEntity> list = [];
      for (var ele in result) {
        list.add(GuideDetailsEntity.fromJson(ele.toJson()));
      }
      setUnfilterGuideList = list;
      setGuideList = list;
      setLoading = false;
    });
  }

  Future<String?> preProcessContent(ChapterModel chapter) async {
    return await GetGuideDetails(repository)
        .preProcessContent(content: chapter.content, type: chapter.type)
        .then((value) => value.fold((fail) => null, (result) => result));
  }

  add(GuideDetailsEntity payload) async {
    final uid = AppController.instance.currentUser!.uid;
    final failureOrResult =
        await GetGuideDetails(repository).add(data: payload, id: uid);
    failureOrResult.fold((fail) {
      Push.back();
      setFailure = fail;
    }, (result) {
      Push.back();
      Push.back();
      showCustomDialog(content: SuccessDialog());
      get();
    });
  }

  delete(GuideDetailsEntity payload) async {
    final uid = AppController.instance.currentUser!.uid;
    final failureOrResult =
        await GetGuideDetails(repository).delete(data: payload, id: uid);
    failureOrResult.fold((fail) {
      setFailure = fail;
    }, (result) {
      get();
    });
  }

  update(GuideDetailsEntity payload) async {
    final uid = AppController.instance.currentUser!.uid;
    final failureOrResult =
        await GetGuideDetails(repository).update(data: payload, id: uid);
    failureOrResult.fold((fail) {
      setFailure = fail;
    }, (result) {
      get();
    });
  }

  Future<void> pickAndExtractText(
      ChapterModel chapter, String filePath, String extension) async {
    switch (extension) {
      case 'png':
      case 'jpg':
      case 'jpeg':
        contentChange(chapter, await extractTextFromImage(filePath));
      case 'pdf':
        contentChange(chapter, await extractTextFromPdf(filePath));
      case 'txt':
        contentChange(chapter, await readTextFile(filePath));
      case 'doc':
        contentChange(chapter, await readDocFile(filePath));
      default:
        return;
    }
  }

  //Scanning Text from PDF
  Future<String> extractTextFromPdf(String filePath) async {
    final File data = File(filePath);
    final List<int> bytes = data.readAsBytesSync();
    PdfDocument document = PdfDocument(inputBytes: bytes);
    String text = PdfTextExtractor(document).extractText();
    document.dispose();

    return text;
  }

  //Scanning Text from .txt file
  Future<String> readTextFile(String filePath) async {
    final String content = await File(filePath).readAsString();
    return content;
  }

  //Scanning Text from .docx file
  Future<String> readDocFile(String filePath) async {
    final file = File(filePath);
    final bytes = await file.readAsBytes();
    final text = docxToText(bytes);
    return text;
  }

  //Scanning Text from Images
  Future<String> extractTextFromImage(String imagePath) async {
    final InputImage inputImage = InputImage.fromFilePath(imagePath);
    final textRecognizer = TextRecognizer();
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);
    await textRecognizer.close();
    return recognizedText.text;
  }
}
