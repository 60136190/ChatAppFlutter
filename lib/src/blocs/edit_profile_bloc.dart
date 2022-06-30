import 'dart:async';
import 'dart:io';
import 'package:task1/src/ui/mypage/edit_profile_screen.dart';
import 'package:task1/src/utils/ng_words.dart' as NGWords;
import 'package:flutter/cupertino.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task1/src/blocs/bloc.dart';
import 'package:task1/src/models/picker_model.dart';
import 'package:task1/src/models/profile_model.dart';
import 'package:task1/src/services/check_permission.dart';
import 'package:task1/src/storages/auth_store.dart';
import 'package:task1/src/storages/mypage_store.dart';
import 'package:task1/src/storages/store.dart';
import 'package:task1/src/storages/system_store.dart';
import 'package:task1/src/ui/test.dart';
import 'package:task1/src/utils/utils.dart';

import '../models/detail_user_model.dart';

class EditProfileBloc {
  final _myPage = store<MyPageStore>();
  final listPicker = store<SystemStore>().serverState.userProfileList;


  var profileUpdate = Profile();
  final isChanged = Bloc<bool>(initialValue: false);

  List<File> images;
  List<num> viewStatus;
  num isMain;


  final loading = Bloc<bool>(initialValue: false);

  final imageUrl = Bloc<List>();

  final height = Bloc<int>.broadcast();
  final style = Bloc<int>.broadcast();
  final job = Bloc<int>.broadcast();
  final income = Bloc<int>.broadcast();

  String cachedStatus;
  StreamController<String> _statusController = StreamController.broadcast();

  StreamController<PickerModel> _areaStream = StreamController.broadcast();
  StreamController<PickerModel> _heightStream = StreamController.broadcast();
  StreamController<PickerModel> _roommateStream = StreamController.broadcast();
  StreamController<PickerModel> _birthplaceStream =
  StreamController.broadcast();
  StreamController<PickerModel> _relationshipStatusStream =
  StreamController.broadcast();
  StreamController<PickerModel> _childStream = StreamController.broadcast();
  StreamController<PickerModel> _educationStream = StreamController.broadcast();
  StreamController<PickerModel> _jobStream = StreamController.broadcast();
  StreamController<PickerModel> _incomeStream = StreamController.broadcast();
  StreamController<PickerModel> _holidaysStream = StreamController.broadcast();
  StreamController<PickerModel> _drinkingStream = StreamController.broadcast();
  StreamController<PickerModel> _smokingStream = StreamController.broadcast();
  StreamController<PickerModel> _meetingConditionStream =
  StreamController.broadcast();
  StreamController<PickerModel> _purposeStream = StreamController.broadcast();

  StreamController<String> get statusStream => _statusController;

  StreamController<PickerModel> get areaStream => _areaStream;

  StreamController<PickerModel> get heightStream => _heightStream;

  StreamController<PickerModel> get roommateStream => _roommateStream;

  StreamController<PickerModel> get birthplaceStream => _birthplaceStream;

  StreamController<PickerModel> get relationshipStatusStream =>
      _relationshipStatusStream;

  StreamController<PickerModel> get childStream => _childStream;

  StreamController<PickerModel> get educationStream => _educationStream;

  StreamController<PickerModel> get jobStream => _jobStream;

  StreamController<PickerModel> get incomeStream => _incomeStream;

  StreamController<PickerModel> get holidaysStream => _holidaysStream;

  StreamController<PickerModel> get drinkingStream => _drinkingStream;

  StreamController<PickerModel> get smokingStream => _smokingStream;

  StreamController<PickerModel> get meetingStream => _meetingConditionStream;

  StreamController<PickerModel> get purposeStream => _purposeStream;

  final email = TextEditingController();

  final moodStatus = TextEditingController();

  final hobby = TextEditingController();
  final favoritePlace = TextEditingController();
  final firstPlace = TextEditingController();


  Future updateProfile(
      Profile profile,
      PickerModel height,
      PickerModel style,
      PickerModel job,
      PickerModel income,
      String userStatus,
      Function onSuccess) async {
    if (isChanged.value) {
      if (height != null) profile.height = height;
      if (style != null) profile.style = style;
      if (job != null) profile.job = job;
      if (income != null) profile.income = income;
      profile.userStatus = userStatus;
      // loading.add(true);
      var profileUpdate = {
        'height': height?.value.toString(),
        'style': style?.value.toString(),
        'job': job?.value.toString(),
        'income': income?.value.toString(),
        'user_status': userStatus
      };
      await _myPage.updateProfile(profileUpdate, onSuccess: onSuccess);
      var data = await _myPage.getMyPage();
      if (data != null) {
        profile = data;
      }
      isChanged.add(false);
      // loading.add(false);
    }
  }

  Future checkNGWordAndUpdateProfile(
      Function onSuccess, void Function() onNGWordsFound) async {
    if (isChanged.value) {
      if (NGWords.check(moodStatus.text, NGWords.ngWordsList) ||
          NGWords.check(cachedStatus, NGWords.ngWordsList)) {
        onNGWordsFound?.call();
        return;
      }
      loading.add(true);
      await _myPage.updateProfile(profileUpdate.toJson(), onSuccess: onSuccess);
      isChanged.add(false);
      loading.add(false);
    }
  }

  Future updateImage(Function onSuccess) async {
    if (images != null) {
      // loading.add(true);
      await _myPage.updateImage(images, onSuccess: onSuccess);
      store<AuthStore>().userAvatar.add(images[0]);
      // loading.add(false);
    }
    isChanged.add(false);
  }

  Future getImage(num position) async {
    print("okokok");
    if (await CheckPermission.photos) {
      PickedFile imagePicker = await Utils.getImageFromGallery();

      if (imagePicker == null) return;
      final File image = File(imagePicker.path);

      final _newPath = image.absolute.path
          .replaceAll('.jpg', '')
          .replaceAll('.jpeg', '')
          .replaceAll('.png', '')
          .replaceAll('.gif', '')
          .replaceAll('image_picker', '');

      var newImage = await FlutterImageCompress.compressAndGetFile(
          image.absolute.path, _newPath + '_compressed.jpg',
          quality: 80, minWidth: 1024
        // rotate: 180,
      );

      print(image.lengthSync());
      print(newImage.lengthSync());

      if (images == null) images = List(EditProfileScreen.numberAvatar);

      images[position] = newImage; //image;
      imageUrl.add(images);
      isChanged.add(true);
    }
  }

  // Future showDialog(BuildContext context, num position) async {
  //   final isMain = await SettingAvatar.mainAvatar(context);
  //   if (isMain == 1) {
  //     this.isMain = position;
  //     isChanged.add(true);
  //   } else {
  //     final show = await SettingAvatar.showAvatar(context);
  //     if (show != null) {
  //       if (viewStatus == null) viewStatus = List(EditProfileScreen.numberAvatar);
  //       viewStatus[position] = show;
  //       isChanged.add(true);
  //     }
  //   }
  // }

  void dispose() {
    loading.dispose();
    imageUrl.dispose();

    email.dispose();
    moodStatus.dispose();
    _statusController.close();

    _areaStream.close();
    _heightStream.close();
    _roommateStream.close();
    _birthplaceStream.close();
    _relationshipStatusStream.close();
    _childStream.close();
    _educationStream.close();
    _jobStream.close();
    _incomeStream.close();
    _holidaysStream.close();
    hobby.dispose();
    favoritePlace.dispose();
    firstPlace.dispose();
    _drinkingStream.close();
    _smokingStream.close();

    _meetingConditionStream.close();
    _purposeStream.close();

    height.dispose();
    style.dispose();
    job.dispose();
    income.dispose();
  }
}
