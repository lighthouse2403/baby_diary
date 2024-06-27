import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:baby_diary/_gen/assets.gen.dart';
import 'package:baby_diary/common/base/base_statefull_widget.dart';
import 'package:baby_diary/common/constants/app_colors.dart';
import 'package:baby_diary/common/extension/date_time_extension.dart';
import 'package:baby_diary/common/extension/text_extension.dart';
import 'package:baby_diary/common/widgets/action_sheet/bottom_sheet_action.dart';
import 'package:baby_diary/common/widgets/action_sheet/bottom_sheet_alert.dart';
import 'package:baby_diary/common/widgets/action_sheet/cancel_action.dart';
import 'package:baby_diary/common/widgets/customTextField.dart';
import 'package:baby_diary/common/widgets/custom_button.dart';
import 'package:baby_diary/common/widgets/date_picker/date_picker_2.dart';
import 'package:baby_diary/diary/bloc/diary_detail_bloc.dart';
import 'package:baby_diary/diary/bloc/diary_event.dart';
import 'package:baby_diary/diary/bloc/diary_state.dart';
import 'package:baby_diary/diary/model/diary.dart';
import 'package:baby_diary/diary/widgets/image_list.dart';
import 'package:baby_diary/routes/routes.dart';

class DiaryDetail extends BaseStatefulWidget {
  DiaryDetail({super.key, required this.initialDiary});
  Diary? initialDiary;

  @override
  State<DiaryDetail> createState() => _DiaryState();
}

class _DiaryState extends BaseStatefulState<DiaryDetail> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  DiaryDetailBloc diaryDetailBloc = DiaryDetailBloc();

  @override
  void initState() {
    diaryDetailBloc.add(InitDiary(widget.initialDiary));
    titleController.text = widget.initialDiary?.title ?? '';
    contentController.text = widget.initialDiary?.content ?? '';
    super.initState();
  }

  @override
  PreferredSizeWidget? buildAppBar() {
    DateTime currentTime = diaryDetailBloc.curentDiary.time;
    String title = currentTime.globalDateFormat();
    return AppBar(
      title: InkWell(
        onTap: () async {
          final date = await showDatePicker2(
            context: context,
            initialDate: currentTime,
            firstDate: DateTime(DateTime.now().year - 1),
            currentDate: DateTime.now(),
            lastDate: DateTime(DateTime.now().year + 2),
            cancelText: 'Huỷ',
            confirmText: 'Xong',
          );
          setState(() {
            diaryDetailBloc.curentDiary.time = date ?? DateTime.now();
          });
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title).w500().text16().whiteColor(),
            const SizedBox(height: 4),
            Assets.icons.arrowDown.svg(
                width: 16,
                height: 16,
                colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn)
            )
          ],
        ),
      ),
      backgroundColor: AppColors.mainColor,
      leading: InkWell(
        onTap: () => Routes.instance.pop(),
        child: Align(
          alignment: Alignment.center,
          child: Assets.icons.arrowBack.svg(width: 24, height: 24),
        ),
      ),
      actions: [
        InkWell(
          onTap: () {
            showAdaptiveActionSheet(
              context: context,
              actions: <BottomSheetAction>[
                _openLibrary(ImageSource.gallery, 'Thư viện'),
                _openLibrary(ImageSource.camera, 'Máy ảnh')
              ],
              cancelAction: CancelAction(
                  title: const Text('Huỷ').text14().w400().redColor()
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(right: 12),
            child: Assets.icons.png.camera.image(width: 24, height: 24),
          ),
        )
      ],
    );
  }

  @override
  Widget? buildBody() {
    return BlocProvider(
        create: (context) => diaryDetailBloc,
        child: BlocListener<DiaryDetailBloc, DiaryState> (
            listener: (context, state) async {
              if (state is SaveDiarySuccessful) {
                await Fluttertoast.showToast(
                    msg: 'Đã lưu nhật ký thành công',
                    gravity:  ToastGravity.CENTER,
                    timeInSecForIosWeb: 2
                );
                Routes.instance.pop();
              }
              if (state is SaveDiaryFail) {
                Fluttertoast.showToast(
                    msg: 'Vui lòng nhập tiêu đề để lưu',
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 2
                );
              }
              if (state is AddingPathSuccessful) {
                setState(() {});
              }
              if (state is DeletingPathSuccessful) {
                setState(() {});
              }

              if (state is InitDiarySuccessful) {
                setState(() {
                });
              }
            },
            child: Container(
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              decoration: const BoxDecoration(
                color: Colors.white
                // image: DecorationImage(
                //     image: AssetImage('assets/images/pregnancy_backgroound_3.jpg'),
                //     fit: BoxFit.cover),
              ),
              child: SafeArea(
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: const Text('Tiêu đề').w400().text15().blackColor().left(),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(height: 10),
                    ),
                    SliverToBoxAdapter(
                      child: CustomTextField(
                        controller: titleController,
                        onTextChanged: (value) {
                          diaryDetailBloc.curentDiary.title = value;
                        },
                        hintText: 'Tiêu đề',
                        maxLines: 2,
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(height: 20),
                    ),
                    SliverToBoxAdapter(
                      child: const Text('Nội dung').w400().text15().blackColor().left(),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(height: 10),
                    ),
                    SliverToBoxAdapter(
                      child: CustomTextField(
                        controller: contentController,
                        onTextChanged: (value) {
                          diaryDetailBloc.curentDiary.content = value;
                        },
                        hintText: 'Nội dung',
                        maxLines: 10,
                        minLines: 4,
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(height: 20),
                    ),
                    ImageList(
                      imagePaths: diaryDetailBloc.curentDiary.mediaUrl,
                      deletepath: (path) {
                        diaryDetailBloc.add(DeletedPath(path));
                      },
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(height: 20),
                    ),
                    SliverToBoxAdapter(
                      child: CustomButton(
                          titleColor: Colors.white,
                          backgroundColor: AppColors.mainColor,
                          onTappedAction: () {
                            if (widget.initialDiary != null) {
                              diaryDetailBloc.add(const EditDiary());
                            } else {
                              diaryDetailBloc.add(const CreateDiary());
                            }
                          },
                          title: 'Lưu'
                      ),
                    )
                  ]
                ),
              ),
            )
        )
    );
  }

  BottomSheetAction _openLibrary(ImageSource source, String title) {
    return BottomSheetAction(
      title: Text(title).text14().w400().blackColor(),
      onPressed: (_) async {
        final XFile? pickedFile = await _picker.pickImage(source: source);
        String filePath = pickedFile?.path ?? '';
        diaryDetailBloc.add(AddedPath(filePath));
      },
    );
  }
}