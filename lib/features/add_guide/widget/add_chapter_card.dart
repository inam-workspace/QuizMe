import 'package:quiz_me/main/imports.dart';

class AddChapterCard extends StatelessWidget {
  final AddGuideProvider provider;
  final ChapterModel chapter;
  final Function()? remove;
  const AddChapterCard({
    super.key,
    required this.chapter,
    this.remove,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: gapAll(8.0),
      padding: gapSymmetric(vertical: 20, horizontal: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 0),
            spreadRadius: 2,
            blurRadius: 2,
            color: Theme.of(context).hintColor.withOpacity(0.25),
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                'Chapter Name',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              if (remove != null)
                CustomButton(
                  elevation: 0,
                  width: h(35),
                  height: h(35),
                  widget: Icon(
                    Icons.delete_outline_rounded,
                    size: h(20),
                    color: Theme.of(context).colorScheme.scrim,
                  ),
                  onPressed: remove!,
                  backgroundColor: Theme.of(context).cardColor,
                  borderRadius: 35,
                ),
            ],
          ),
          Text(
            'Enter your chapter name i.e Chapter 1',
            style: Theme.of(context).textTheme.labelLarge,
          ),
          SizedBox(height: h(10)),
          TextFormField(
            controller: chapter.controller,
            cursorColor: Theme.of(context).primaryColor,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            style: Theme.of(context).textTheme.bodyMedium,
            decoration: InputDecoration(
              isDense: true,
              filled: true,
              hintText: 'Write here ..',
              hintStyle: Theme.of(context).textTheme.labelLarge,
              fillColor: Theme.of(context).cardColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          SizedBox(height: h(10)),
          Row(
            children: [
              Flexible(
                child: MaterialButton(
                  elevation: 0,
                  visualDensity: VisualDensity.compact,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding: gapZero,
                  onPressed: () {
                    provider.toggleType(chapter, ChapterType.media);
                  },
                  height: h(40),
                  minWidth: double.infinity,
                  color: chapter.type == ChapterType.media
                      ? Theme.of(context).cardColor
                      : Theme.of(context).scaffoldBackgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(
                      color: chapter.type == ChapterType.media
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).hintColor,
                      width: w(1),
                    ),
                  ),
                  child: ListTile(
                    contentPadding: gapSymmetric(horizontal: 10),
                    dense: true,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      'Media',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: w(12),
                          ),
                    ),
                    trailing: chapter.type == ChapterType.media
                        ? SvgPicture.asset('assets/icons/check_true.svg')
                        : SvgPicture.asset(
                            'assets/icons/check_false.svg',
                            colorFilter: ColorFilter.mode(
                              Theme.of(context).hintColor,
                              BlendMode.srcIn,
                            ),
                          ),
                  ),
                ),
              ),
              SizedBox(width: w(10)),
              Flexible(
                child: MaterialButton(
                  elevation: 0,
                  visualDensity: VisualDensity.compact,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding: gapZero,
                  onPressed: () {
                    provider.toggleType(chapter, ChapterType.notes);
                  },
                  height: h(40),
                  minWidth: double.infinity,
                  color: chapter.type == ChapterType.notes
                      ? Theme.of(context).cardColor
                      : Theme.of(context).scaffoldBackgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(
                      color: chapter.type == ChapterType.notes
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).hintColor,
                      width: w(1),
                    ),
                  ),
                  child: ListTile(
                    contentPadding: gapSymmetric(horizontal: 10),
                    dense: true,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      'Notes',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: w(12),
                          ),
                    ),
                    trailing: chapter.type == ChapterType.notes
                        ? SvgPicture.asset('assets/icons/check_true.svg')
                        : SvgPicture.asset(
                            'assets/icons/check_false.svg',
                            colorFilter: ColorFilter.mode(
                              Theme.of(context).hintColor,
                              BlendMode.srcIn,
                            ),
                          ),
                  ),
                ),
              ),
              SizedBox(width: w(10)),
              Flexible(
                child: MaterialButton(
                  elevation: 0,
                  visualDensity: VisualDensity.compact,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding: gapZero,
                  onPressed: () {
                    provider.toggleType(chapter, ChapterType.link);
                  },
                  height: h(40),
                  minWidth: double.infinity,
                  color: chapter.type == ChapterType.link
                      ? Theme.of(context).cardColor
                      : Theme.of(context).scaffoldBackgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(
                      color: chapter.type == ChapterType.link
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).hintColor,
                      width: w(1),
                    ),
                  ),
                  child: ListTile(
                    contentPadding: gapSymmetric(horizontal: 10),
                    dense: true,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      'YT Link',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: w(12),
                          ),
                    ),
                    trailing: chapter.type == ChapterType.link
                        ? SvgPicture.asset('assets/icons/check_true.svg')
                        : SvgPicture.asset(
                            'assets/icons/check_false.svg',
                            colorFilter: ColorFilter.mode(
                              Theme.of(context).hintColor,
                              BlendMode.srcIn,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: h(10)),
          if (chapter.type == ChapterType.media)
            MaterialButton(
              padding: gapZero,
              color: Theme.of(context).scaffoldBackgroundColor,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                  color: Theme.of(context).hintColor.withOpacity(0.5),
                  width: w(1),
                ),
              ),
              visualDensity: VisualDensity.compact,
              onPressed: () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: [
                    'png',
                    'jpg',
                    'jpeg',
                    'pdf',
                    'txt',
                    'doc'
                  ],
                );
                if (result != null) {
                  final filePath = result.files.single.path!;
                  final extension = result.files.single.extension!;
                  await provider.pickAndExtractText(chapter,filePath,extension);
                }
              },
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              child: ListTile(
                leading: SvgPicture.asset(
                  'assets/icons/upload.svg',
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.scrim,
                    BlendMode.srcIn,
                  ),
                ),
                dense: true,
                title: RichText(
                  maxLines: 1,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Upload File ',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      TextSpan(
                        text: '(png, jpg, pdf, txt)',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                ),
                subtitle: chapter.content != ''
                    ? Text(
                        chapter.content.split('/').last.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).primaryTextTheme.bodySmall,
                      )
                    : null,
              ),
            )
          else if (chapter.type == ChapterType.link)
            TextFormField(
              onChanged: (value) => provider.contentChange(chapter, value),
              cursorColor: Theme.of(context).primaryColor,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              style: Theme.of(context).textTheme.bodyMedium,
              decoration: InputDecoration(
                isDense: true,
                filled: true,
                hintText: 'Write here ..',
                prefixIcon: Padding(
                  padding: gapAll(14.0),
                  child: SvgPicture.asset(
                    'assets/icons/attach.svg',
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.scrim,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                hintStyle: Theme.of(context).textTheme.labelLarge,
                fillColor: Theme.of(context).scaffoldBackgroundColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                      color: Theme.of(context).hintColor.withOpacity(0.5)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                      color: Theme.of(context).hintColor.withOpacity(0.5)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                      color: Theme.of(context).hintColor.withOpacity(0.5)),
                ),
              ),
            )
          else
            TextFormField(
              onChanged: (value) => provider.contentChange(chapter, value),
              cursorColor: Theme.of(context).primaryColor,
              keyboardType: TextInputType.text,
              maxLines: 4,
              textInputAction: TextInputAction.done,
              style: Theme.of(context).textTheme.bodyMedium,
              decoration: InputDecoration(
                isDense: true,
                filled: true,
                hintText: 'Write here ..',
                hintStyle: Theme.of(context).textTheme.labelLarge,
                fillColor: Theme.of(context).scaffoldBackgroundColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                      color: Theme.of(context).hintColor.withOpacity(0.5)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                      color: Theme.of(context).hintColor.withOpacity(0.5)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                      color: Theme.of(context).hintColor.withOpacity(0.5)),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
