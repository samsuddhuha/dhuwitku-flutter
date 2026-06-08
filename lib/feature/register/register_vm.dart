// import 'package:flutter/material.dart';
// import 'package:inacash_ewallet/core/base/base_vm.dart';
// import 'package:inacash_ewallet/network/remotedata/auth/auth_remote_data.dart';
// import 'package:inacash_ewallet/network/remotedata/auth/model/register_user_model.dart';
// import 'package:inacash_ewallet/network/remotedata/main/main_remote_data.dart';
// import 'package:inacash_ewallet/network/remotedata/main/model/city_model.dart';
// import 'package:inacash_ewallet/network/remotedata/main/model/district_model.dart';
// import 'package:inacash_ewallet/network/remotedata/main/model/province_model.dart';
// import 'package:inacash_ewallet/network/remotedata/main/model/village_model.dart';
// import 'package:inacash_ewallet/util/helper/snackbar.dart';

// class RegisterVm extends BaseVm {
//   final BuildContext context;
//   final MainRemoteData _mainRemoteData = MainRemoteData();
//   final AuthRemoteData _authRemoteData = AuthRemoteData();

//   RegisterVm(this.context) {
//     getProvinces();
//     // fillDemoData();
//   }

//   final nameController = TextEditingController();
//   final emailController = TextEditingController();
//   final phoneNumberController = TextEditingController();

//   final provinceController = TextEditingController();
//   final cityController = TextEditingController();
//   final districtController = TextEditingController();
//   final villageController = TextEditingController();
//   final addressController = TextEditingController();

//   final passwordController = TextEditingController();
//   final confirmPasswordController = TextEditingController();

//   List<ProvinceModel> provinces = [];
//   List<CityModel> cities = [];
//   List<DistrictModel> districts = [];
//   List<VillageModel> villages = [];

//   ProvinceModel? selectedProvince;
//   CityModel? selectedCity;
//   DistrictModel? selectedDistrict;
//   VillageModel? selectedVillage;

//   String? nameError;
//   String? emailError;
//   String? phoneNumberError;
//   String? addressError;

//   String? passwordError;
//   String? confirmPasswordError;

//   void fillDemoData() {
//     nameController.text = "Member";
//     emailController.text = "member@gmail.com";
//     phoneNumberController.text = "085829703799";
//     notifyListeners();
//   }

//   bool validateName() {
//     final name = nameController.text.trim();

//     if (name.isEmpty) {
//       nameError = "Nama tidak boleh kosong";
//     } else {
//       nameError = null;
//     }

//     notifyListeners();
//     return nameError == null;
//   }

//   void validateEmail() {
//     final email = emailController.text.trim();

//     if (email.isEmpty) {
//       emailError = "Email tidak boleh kosong";
//     } else if (!RegExp(r"^[\w\.-]+@[\w\.-]+\.\w+$").hasMatch(email)) {
//       emailError = "Format email tidak valid";
//     } else {
//       emailError = null;
//     }

//     notifyListeners();
//   }

//   void validatePhone() {
//     final phone = phoneNumberController.text.trim();

//     if (phone.isEmpty) {
//       phoneNumberError = "Nomor telepon tidak boleh kosong";
//     }
//     // hanya angka
//     else if (!RegExp(r'^[0-9]+$').hasMatch(phone)) {
//       phoneNumberError = "Nomor telepon hanya boleh berisi angka";
//     }
//     // panjang minimal
//     else if (phone.length < 10) {
//       phoneNumberError = "Nomor telepon minimal 10 digit";
//     }
//     // panjang maksimal
//     else if (phone.length > 13) {
//       phoneNumberError = "Nomor telepon maksimal 13 digit";
//     }
//     // format Indonesia
//     else if (!(phone.startsWith('08') || phone.startsWith('62'))) {
//       phoneNumberError = "Nomor telepon harus diawali dengan 08 atau 62";
//     } else {
//       phoneNumberError = null;
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

//   // 🔹 Validasi Password
//   void validatePassword() {
//     final password = passwordController.text.trim();

//     if (password.isEmpty) {
//       passwordError = "Kata sandi tidak boleh kosong";
//     } else {
//       passwordError = null;
//     }
//     if (confirmPasswordController.text.trim() ==
//         passwordController.text.trim()) {
//       passwordError = null;
//       confirmPasswordError = null;
//     }

//     notifyListeners();
//   }

//   void validateConfirmPassword() {
//     final confirmPassword = confirmPasswordController.text.trim();

//     if (confirmPassword.isEmpty) {
//       confirmPasswordError = "Konfirmasi kata sandi tidak boleh kosong";
//     } else {
//       confirmPasswordError = null;
//     }
//     if (confirmPasswordController.text.trim() ==
//         passwordController.text.trim()) {
//       passwordError = null;
//       confirmPasswordError = null;
//     }

//     notifyListeners();
//   }

//   void submit() {
//     if (confirmPasswordController.text.trim() !=
//         passwordController.text.trim()) {
//       confirmPasswordError = "Konfirmasi password harus sama";
//       passwordError = "Konfirmasi password harus sama";
//       notifyListeners();
//     } else {
//       submitRegister();
//     }
//   }

//   bool get isFormValid {
//     return nameError == null &&
//         emailError == null &&
//         phoneNumberError == null &&
//         addressError == null &&
//         passwordError == null &&
//         confirmPasswordError == null &&
//         nameController.text.isNotEmpty &&
//         emailController.text.isNotEmpty &&
//         phoneNumberController.text.isNotEmpty &&
//         provinceController.text.isNotEmpty &&
//         cityController.text.isNotEmpty &&
//         districtController.text.isNotEmpty &&
//         villageController.text.isNotEmpty &&
//         addressController.text.isNotEmpty &&
//         passwordController.text.isNotEmpty &&
//         confirmPasswordController.text.isNotEmpty;
//   }

//   Future<void> submitRegister() async {
//     try {
//       final payload = RegisterUserModel(
//         fullname: nameController.text.trim(),
//         email: emailController.text.trim(),
//         phone: phoneNumberController.text.trim(),
//         provinceID: int.parse(selectedProvince!.id),
//         cityID: int.parse(selectedCity!.id),
//         districtID: int.parse(selectedDistrict!.id),
//         villageID: int.parse(selectedVillage!.id),
//         address: addressController.text.trim(),
//         password: passwordController.text.trim(),
//       );
//       final _ = await _authRemoteData.register(registerData: payload);

//       if (!context.mounted) return;
//       SnackbarHelper.show(
//         context,
//         'Pendaftaran Akun Berhasil, Silahkan Login.',
//       );
//       Navigator.pop(context);
//     } catch (e) {
//       if (!context.mounted) return;
//       setError(context, e.toString().replaceFirst('Exception: ', ''));
//     }
//   }

//   void selectProvince(String name) {
//     final province = provinces.firstWhere((e) => e.name == name);

//     provinceController.text = name;
//     cityController.text = '';
//     districtController.text = '';
//     villageController.text = '';

//     selectedProvince = province;
//     selectedCity = null;
//     selectedDistrict = null;
//     selectedVillage = null;
//     getCities();
//   }

//   void selectCity(String name) {
//     final city = cities.firstWhere((e) => e.name == name);

//     cityController.text = name;
//     districtController.text = '';
//     villageController.text = '';

//     selectedCity = city;
//     selectedDistrict = null;
//     selectedVillage = null;
//     getDistricts();
//   }

//   void selectDistrict(String name) {
//     final district = districts.firstWhere((e) => e.name == name);

//     districtController.text = name;
//     villageController.text = '';

//     selectedDistrict = district;
//     selectedVillage = null;
//     getVillages();
//   }

//   void selectVillage(String name) {
//     final village = villages.firstWhere((e) => e.name == name);

//     villageController.text = name;

//     selectedVillage = village;
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

//   Future<void> getVillages() async {
//     try {
//       final response = await _mainRemoteData.getVillage(
//         districtID: selectedDistrict?.id ?? '',
//       );

//       final Map<String, dynamic> json = response;

//       final data = json['data'] as Map<String, dynamic>;
//       final List list = data['villages'] ?? [];

//       villages = list
//           .map((e) => VillageModel.fromJson(e as Map<String, dynamic>))
//           .toList();

//       notifyListeners();
//     } catch (e) {
//       if (!context.mounted) return;
//       setError(context, e.toString().replaceFirst('Exception: ', ''));
//     }
//   }
// }
