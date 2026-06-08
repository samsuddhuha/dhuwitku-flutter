// import 'package:flutter/material.dart';
// import 'package:inacash_bisnis/component/bottomsheet/confirm_bottom_sheet.dart';
// import 'package:inacash_bisnis/core/base/base_vm.dart';
// import 'package:inacash_bisnis/core/session/session.dart';
// import 'package:inacash_bisnis/network/remotedata/auth/model/merchant_model.dart';
// import 'package:inacash_bisnis/network/remotedata/main/main_remote_data.dart';
// import 'package:inacash_bisnis/network/remotedata/main/model/bank_model.dart';
// import 'package:inacash_bisnis/network/remotedata/main/model/city_model.dart';
// import 'package:inacash_bisnis/network/remotedata/main/model/district_model.dart';
// import 'package:inacash_bisnis/network/remotedata/main/model/province_model.dart';
// import 'package:inacash_bisnis/network/remotedata/user/user_remote_data.dart';
// import 'package:inacash_bisnis/util/helper/snackbar.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:share_plus/share_plus.dart';

// class RegisterMerchantVm extends BaseVm {
//   final BuildContext context;
//   final bool isCompany;

//   final MainRemoteData _mainRemoteData = MainRemoteData();
//   final UserRemoteData _userRemoteData = UserRemoteData();

//   RegisterMerchantVm(this.context, this.isCompany) {
//     getMerchant();
//     getProvinces();
//     getBanks();
//     // fillDemoData();
//   }

//   final merchantNameController = TextEditingController();
//   final criteriaController = TextEditingController();
//   final npwpController = TextEditingController();

//   final nikController = TextEditingController();

//   final provinceController = TextEditingController();
//   final cityController = TextEditingController();
//   final districtController = TextEditingController();
//   final addressController = TextEditingController();
//   final postalCodeController = TextEditingController();

//   final bankController = TextEditingController();
//   final accountNumberController = TextEditingController();
//   final accountNameController = TextEditingController();

//   List<String> listCriteria = [
//     "UMI : Usaha Mikro",
//     "UKE : Usaha Kecil",
//     "UME : Usaha Menengah",
//     "UBE : Usaha Besar",
//     "URE : Usaha Regular",
//   ];

//   List<ProvinceModel> provinces = [];
//   List<CityModel> cities = [];
//   List<DistrictModel> districts = [];

//   List<BankModel> banks = [];

//   ProvinceModel? selectedProvince;
//   CityModel? selectedCity;
//   DistrictModel? selectedDistrict;
//   BankModel? selectedBank;

//   String? merchantNameError;
//   String? npwpError;
//   String? nikError;

//   String? addressError;
//   String? postalCodeError;

//   String? accountNumberError;
//   String? accountNameError;

//   XFile? idCardImage;
//   XFile? frontMerchantImage;
//   XFile? insideMerchantImage;
//   XFile? cashierImage;

//   MerchantModel? merchant;

//   void fillDemoData() {
//     notifyListeners();
//   }

//   Future<bool> requestCameraPermission() async {
//     var status = await Permission.camera.status;

//     if (status.isGranted) return true;

//     status = await Permission.camera.request();

//     return status.isGranted;
//   }

//   Future<void> getMerchant() async {
//     merchant = await Session.instance.getMerchant();
//   }

//   bool validateMerchantName() {
//     final name = merchantNameController.text.trim();

//     if (name.isEmpty) {
//       merchantNameError = "Nama merchant tidak boleh kosong";
//     } else {
//       merchantNameError = null;
//     }

//     notifyListeners();
//     return merchantNameError == null;
//   }

//   void validateNpwp() {
//     final npwp = npwpController.text.trim();

//     if (!isCompany) {
//       npwpError = null;
//       notifyListeners();
//       return;
//     }

//     if (npwp.isEmpty) {
//       npwpError = "NPWP tidak boleh kosong";
//     } else if (!RegExp(r'^[0-9]+$').hasMatch(npwp)) {
//       npwpError = "NPWP hanya boleh berisi angka";
//     } else if (npwp.length < 15) {
//       npwpError = "NPWP minimal 15 digit";
//     } else if (npwp.length > 15) {
//       npwpError = "NPWP maksimal 15 digit";
//     } else {
//       npwpError = null;
//     }

//     notifyListeners();
//   }

//   void validateNik() {
//     final nik = nikController.text.trim();

//     if (nik.isEmpty) {
//       nikError = "NIK tidak boleh kosong";
//     } else if (!RegExp(r'^[0-9]+$').hasMatch(nik)) {
//       nikError = "NIK hanya boleh berisi angka";
//     } else if (nik.length < 16) {
//       nikError = "NIK minimal 16 digit";
//     } else if (nik.length > 16) {
//       nikError = "NIK maksimal 16 digit";
//     } else {
//       nikError = null;
//     }

//     notifyListeners();
//   }

//   void validateAddress() {
//     final address = addressController.text.trim();

//     if (address.isEmpty) {
//       addressError = "Alamat lengkap tidak boleh kosong";
//     } else {
//       addressError = null;
//     }

//     notifyListeners();
//   }

//   void validatePostalCode() {
//     final text = postalCodeController.text.trim();

//     if (text.isEmpty) {
//       postalCodeError = "Kode pos tidak boleh kosong";
//     } else {
//       postalCodeError = null;
//     }

//     notifyListeners();
//   }

//   void validateAccountNumber() {
//     final text = accountNumberController.text.trim();

//     if (text.isEmpty) {
//       accountNumberError = "Nomor rekening tidak boleh kosong";
//     } else {
//       accountNumberError = null;
//     }

//     notifyListeners();
//   }

//   void validateAccountName() {
//     final text = accountNameController.text.trim();

//     if (text.isEmpty) {
//       accountNameError = "Nama pemilik rekening tidak boleh kosong";
//     } else {
//       accountNameError = null;
//     }

//     notifyListeners();
//   }

//   void updateIdCardImage(XFile fileImage) {
//     idCardImage = fileImage;

//     notifyListeners();
//   }

//   void updateFrontMerchantImage(XFile fileImage) {
//     frontMerchantImage = fileImage;

//     notifyListeners();
//   }

//   void updateInsideMerchantImage(XFile fileImage) {
//     insideMerchantImage = fileImage;

//     notifyListeners();
//   }

//   void updateCashierImage(XFile fileImage) {
//     cashierImage = fileImage;

//     notifyListeners();
//   }

//   void selectbank(String value) {
//     final bank = banks.firstWhere((e) => e.name == value);

//     bankController.text = value;

//     selectedBank = bank;
//     notifyListeners();
//   }

//   Future<void> getBanks() async {
//     try {
//       final response = await _mainRemoteData.getBank();

//       final Map<String, dynamic> json = response;

//       final data = json['data'] as Map<String, dynamic>;
//       final List list = data['banks'] ?? [];

//       banks = list
//           .map((e) => BankModel.fromJson(e as Map<String, dynamic>))
//           .toList();

//       notifyListeners();
//     } catch (e) {
//       if (!context.mounted) return;
//       setError(context, e.toString().replaceFirst('Exception: ', ''));
//     }
//   }

//   void submit() {
//     String? missingPhotoMessage;

//     if (idCardImage == null) {
//       missingPhotoMessage = "Foto KTP tidak boleh kosong";
//     } else if (frontMerchantImage == null) {
//       missingPhotoMessage = "Foto bagian depan tidak boleh kosong";
//     } else if (insideMerchantImage == null) {
//       missingPhotoMessage = "Foto bagian dalam tidak boleh kosong";
//     } else if (cashierImage == null) {
//       missingPhotoMessage = "Foto kasir tidak boleh kosong";
//     }

//     if (missingPhotoMessage != null) {
//       SnackbarHelper.show(context, missingPhotoMessage);
//       return;
//     }

//     submitRegister();
//   }

//   bool get isFormValid {
//     final isCommonValid =
//         merchantNameError == null &&
//         nikError == null &&
//         addressError == null &&
//         postalCodeError == null &&
//         accountNumberError == null &&
//         accountNameError == null &&
//         merchantNameController.text.isNotEmpty &&
//         criteriaController.text.isNotEmpty &&
//         provinceController.text.isNotEmpty &&
//         cityController.text.isNotEmpty &&
//         districtController.text.isNotEmpty &&
//         addressController.text.isNotEmpty &&
//         postalCodeController.text.isNotEmpty &&
//         bankController.text.isNotEmpty &&
//         accountNumberController.text.isNotEmpty &&
//         accountNameController.text.isNotEmpty;

//     final isCompanyValid =
//         !isCompany || (npwpError == null && npwpController.text.isNotEmpty);

//     return isCommonValid && isCompanyValid;
//   }

//   Future<void> submitRegister() async {
//     try {
//       showLoading(context, true);
//       final criteria = criteriaController.text.split(' :');
//       final _ = await _userRemoteData.registerMerchant(
//         name: merchantNameController.text.trim(),
//         city: cityController.text.trim(),
//         postalCode: postalCodeController.text.trim(),
//         criteria: criteria.first,
//         merchantType: isCompany ? 'CORPORATE' : 'PERSONAL',
//         npwp: npwpController.text.trim(),
//         nik: nikController.text.trim(),
//         accountNumber: accountNumberController.text.trim(),
//         accountVendor: bankController.text.trim(),
//         accountName: accountNameController.text.trim(),
//         identityImage: idCardImage!,
//         storeImage1: frontMerchantImage,
//         storeImage2: insideMerchantImage,
//         storeImage3: cashierImage,
//       );

//       if (!context.mounted) return;
//       showLoading(context, false);
//       showConfirmBottomSheet(
//         context: context,
//         isDismissible: false,
//         title: 'Pendaftaran Merhcant Sedang Di Proses',
//         message:
//             'Data merchant yang Anda kirim akan kami periksa untuk memastikan semuanya sudah lengkap dan sesuai, kami akan menghubungi Anda bila diperlukan. Proses sekitar 1-3 hari kerja.',
//         positiveText: 'Tutup',
//         onPositive: () {
//           getUserProfile();
//         },
//       );
//     } catch (e) {
//       if (!context.mounted) return;
//       showLoading(context, false);
//       setError(context, e.toString().replaceFirst('Exception: ', ''));
//     }
//   }

//   Future<void> getUserProfile() async {
//     try {
//       showLoading(context, true);
//       final response = await _userRemoteData.getUserProfile();

//       final Map<String, dynamic> json = response;

//       final data = json['data'] as Map<String, dynamic>;
//       final user = data['user'] as Map<String, dynamic>;
//       final List merchants = user['user_qrises'] ?? [];

//       await Session.instance.updateUser(user);

//       if (merchants.isNotEmpty) {
//         if (merchant == null) {
//           await Session.instance.saveMerchant(merchants.first);
//         } else {
//           final listMerchant = merchants
//               .map((e) => MerchantModel.fromJson(e as Map<String, dynamic>))
//               .toList();
//           final firstMerchant = listMerchant.firstWhere(
//             (e) => e.mid == merchant?.mid,
//           );
//           await Session.instance.saveMerchant(firstMerchant.toJson());
//         }
//         await Session.instance.saveListMerchant(merchants);
//       }

//       await Session.instance.setReloadData(true);
//       await Session.instance.setReloadMerchant(true);

//       if (!context.mounted) return;
//       showLoading(context, false);
//       Navigator.popUntil(context, (route) => route.isFirst);
//     } catch (e) {
//       if (!context.mounted) return;
//       showLoading(context, false);
//       setError(context, e.toString().replaceFirst('Exception: ', ''));
//     }
//   }

//   void selectCriteria(String value) {
//     final criteria = listCriteria.firstWhere((e) => e == value);

//     criteriaController.text = criteria;
//     notifyListeners();
//   }

//   void selectProvince(String name) {
//     final province = provinces.firstWhere((e) => e.name == name);

//     provinceController.text = name;
//     cityController.text = '';
//     districtController.text = '';

//     selectedProvince = province;
//     selectedCity = null;
//     selectedDistrict = null;
//     getCities();
//   }

//   void selectCity(String name) {
//     final city = cities.firstWhere((e) => e.name == name);

//     cityController.text = name;
//     districtController.text = '';

//     selectedCity = city;
//     selectedDistrict = null;
//     getDistricts();
//   }

//   void selectDistrict(String name) {
//     final district = districts.firstWhere((e) => e.name == name);

//     districtController.text = name;

//     selectedDistrict = district;
//     notifyListeners();
//   }

//   Future<void> getProvinces() async {
//     try {
//       final response = await _mainRemoteData.getProvince();

//       final Map<String, dynamic> json = response;

//       final data = json['data'] as Map<String, dynamic>;
//       final List list = data['provinces'] ?? [];

//       provinces = list
//           .map((e) => ProvinceModel.fromJson(e as Map<String, dynamic>))
//           .toList();

//       notifyListeners();
//     } catch (e) {
//       if (!context.mounted) return;
//       setError(context, e.toString().replaceFirst('Exception: ', ''));
//     }
//   }

//   Future<void> getCities() async {
//     try {
//       final response = await _mainRemoteData.getCity(
//         provinceID: selectedProvince?.id ?? '',
//       );

//       final Map<String, dynamic> json = response;

//       final data = json['data'] as Map<String, dynamic>;
//       final List list = data['cities'] ?? [];

//       cities = list
//           .map((e) => CityModel.fromJson(e as Map<String, dynamic>))
//           .toList();

//       notifyListeners();
//     } catch (e) {
//       if (!context.mounted) return;
//       setError(context, e.toString().replaceFirst('Exception: ', ''));
//     }
//   }

//   Future<void> getDistricts() async {
//     try {
//       final response = await _mainRemoteData.getDistrict(
//         cityID: selectedCity?.id ?? '',
//       );

//       final Map<String, dynamic> json = response;

//       final data = json['data'] as Map<String, dynamic>;
//       final List list = data['districts'] ?? [];

//       districts = list
//           .map((e) => DistrictModel.fromJson(e as Map<String, dynamic>))
//           .toList();

//       notifyListeners();
//     } catch (e) {
//       if (!context.mounted) return;
//       setError(context, e.toString().replaceFirst('Exception: ', ''));
//     }
//   }
// }
