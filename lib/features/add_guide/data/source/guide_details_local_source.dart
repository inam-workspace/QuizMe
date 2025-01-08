import 'package:quiz_me/main/imports.dart';

const cachedGuideDetails = 'GUIDE_DETAILS';

abstract class GuideDetailsLocalSource {
  Future<void> addGuideDetail({required GuideDetailsEntity data});

  Future<List<GuideDetailsModel>> getGuideDetail();

  Future<void> updateGuideDetail({required GuideDetailsEntity data});

  Future<void> deleteGuideDetail({required GuideDetailsEntity data});

  bool containsData({required String id});
}

class GuideDetailsLocalSourceImpl implements GuideDetailsLocalSource {
  final box = Hive.box<GuideDetailsModel>(cachedGuideDetails);

  @override
  addGuideDetail({required GuideDetailsEntity data}) {
    try {
      return box.add(GuideDetailsModel.fromJson(data.toJson()));
    } on Exception {
      throw CacheException();
    }
  }

  @override
  deleteGuideDetail({required GuideDetailsEntity data}) async {
    try {
      final key =
          box.values.firstWhere((value) => data.dateTime == value.dateTime).key;
      box.delete(key);
    } on Exception {
      throw CacheException();
    }
  }

  @override
  getGuideDetail() async {
    try {
      return box.values.toList();
    } on Exception {
      throw CacheException();
    }
  }

  @override
  updateGuideDetail({required GuideDetailsEntity data}) async {
    try {
      final key =
          box.values.firstWhere((value) => data.dateTime == value.dateTime).key;
      box.put(key, GuideDetailsModel.fromJson(data.toJson()));
    } on Exception {
      throw CacheException();
    }
  }

  @override
  bool containsData({required String id}) {
    try {
      if (box.isEmpty) return false;
      final key = box.values.firstWhere((value) => value.authId == id).key;
      if (key == null) return false;
      return box.containsKey(key);
    } on Exception {
      throw CacheException();
    }
  }
}
