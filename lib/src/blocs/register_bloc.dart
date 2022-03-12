// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:task1/src/models/register_model.dart';
//
// import 'bloc.dart';
//
// class RegisterBloc {
//
//   final isLoading = Bloc<bool>.broadcast(initialValue: false);
//
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//
//   final displayNameController = TextEditingController();
//   final genderID = Bloc<int>.broadcast();
//   final age = Bloc<int>.broadcast();
//   final areaID = Bloc<int>.broadcast();
//   // final citiesInAreaCache = Map<int, List<PickerModel>>();
//   // final citiesInArea = Bloc<List<PickerModel>>.broadcast();
//   final cityID = Bloc<int>.broadcast();
//   bool isLegalAge = true;
//   bool didAgreeTermsOfUse = true;
//
//   void resetDeviceTransferFields() {
//     emailController.value = TextEditingValue();
//     passwordController.value = TextEditingValue();
//   }
//
//   Future performDeviceTransfer({void Function() onSuccess}) async {
//     isLoading.add(true);
//     var data;
//     try {
//       data = await RegisterAPI.deviceTransfer(
//           _systemStore.currentDevice.getHeader(),
//           email: emailController.text,
//           password: passwordController.text);
//       // TODO: ????
//       onSuccess?.call();
//     } catch (e, st) {
//       print(e);
//       print(st);
//     } finally {
//       isLoading.add(false);
//     }
//
//     if(data['data'] != null) {
//       print(data);
//       UserLogin userDataFile =
//       new UserLogin(deviceID: _systemStore.currentDevice.deviceID,
//           userCode: data['data']['user_info']['user_code'],
//           password: data['data']['user_info']['device_password']);
//
//       await FileService().writeDataLogin(userDataFile);
//     }
//     return data;
//   }
//
//   Future performDevicePrepare({void Function() onSuccess}) async {
//     isLoading.add(true);
//     var data;
//     final userLogin = await FileService().readDataLogin();
//     try {
//       data = await RegisterAPI.devicePrepare(
//           _systemStore.currentDevice.getHeader(),
//           token: _authStore.userLoginData.token,
//           email: emailController.text,
//           password: passwordController.text,
//           devicePassword: userLogin.password);
//       // TODO: ????
//       onSuccess?.call();
//     } catch (e, st) {
//       print(e);
//       print(st);
//     } finally {
//       isLoading.add(false);
//     }
//     return data;
//   }
//
//   void loadCitiesInArea(int areaID) async {
//     cityID.add(null);
//     if (!citiesInAreaCache.containsKey(areaID)) {
//       isLoading.add(true);
//       try {
//         final apiData = await CitiesAPI.getCities(
//             _systemStore.currentDevice.getHeader(),
//             areaID: areaID);
//         citiesInAreaCache[areaID] = PickerModel.fromJSONs(apiData['data']);
//       } catch (e, st) {
//         print(e);
//         print(st);
//         citiesInArea.addError('エラーが発生しました。しばらくたってからやり直してください。');
//       } finally {
//         isLoading.add(false);
//       }
//     }
//     citiesInArea.add(citiesInAreaCache[areaID]);
//   }
//
//   Future<bool> validateAndRegisterNewUser(
//       {required void Function() onMissingInformation,
//         required void Function() onUncheckedAge,
//         required void Function() onUncheckedTermsOfUse}) async {
//     if (displayNameController.text == null ||
//         displayNameController.text == '' ||
//         genderID.value == null ||
//         age.value == null ||
//         areaID.value == null ||
//         cityID.value == null) {
//       onMissingInformation?.call();
//       return false;
//     }
//     if (!isLegalAge) {
//       onUncheckedAge?.call();
//       return false;
//     }
//     if (!didAgreeTermsOfUse) {
//       onUncheckedTermsOfUse?.call();
//       return false;
//     }
//     return registerNewUser();
//   }
//
//   Future<bool> registerNewUser() async {
//     isLoading.add(true);
//
//     final registerData = RegisterData(
//         displayName: displayNameController.text,
//         password: Utils.randomPassword(8),
//         genderID: genderID.value.toString(),
//         age: age.value.toString(),
//         areaID: areaID.value.toString(),
//         cityID: cityID.value.toString(),
//         carrierName: _systemStore.currentDevice.carrierName,
//         mobileNetworkCode: _systemStore.currentDevice.carrierCode,
//         deviceID: _systemStore.currentDevice.deviceID);
//
//     print('registerData ::: ${registerData.toJson()}');
//
//     try {
//       await _authStore.register(registerData);
//       return true;
//     } catch (e, st) {
//       print(e);
//       print(st);
//       return false;
//     } finally {
//       isLoading.add(false);
//     }
//   }
//
//   void dispose() {
//     isLoading.dispose();
//
//     emailController.dispose();
//     passwordController.dispose();
//
//     displayNameController.dispose();
//     genderID.dispose();
//     age.dispose();
//     areaID.dispose();
//     // citiesInArea.dispose();
//     cityID.dispose();
//   }
// }
