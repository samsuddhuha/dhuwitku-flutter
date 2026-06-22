import 'package:dhuwitku/component/bottomsheet/confirm_bottom_sheet.dart';
import 'package:dhuwitku/component/button/primary_button.dart';
import 'package:dhuwitku/component/button/secondary_button.dart';
import 'package:dhuwitku/component/field/input_dropdown.dart';
import 'package:dhuwitku/component/field/input_field.dart';
import 'package:dhuwitku/component/navbar/navbar.dart';
import 'package:dhuwitku/core/ui/app_images.dart';
import 'package:dhuwitku/feature/home/add_dhuwit_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddDhuwitPage extends StatelessWidget {
  final int? status;
  final int? nominal;
  final String? information;
  final String? dateDhuwit;
  final String? idDhuwit;

  const AddDhuwitPage({
    super.key,
    this.status,
    this.nominal,
    this.information,
    this.dateDhuwit,
    this.idDhuwit,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddDhuwitVm(
        context,
        status,
        nominal,
        information,
        dateDhuwit,
        idDhuwit,
      ),
      child: Consumer<AddDhuwitVm>(
        builder: (context, vm, _) {
          return PopScope(
            canPop: true,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Scaffold(
                extendBodyBehindAppBar: true,
                extendBody: true,
                backgroundColor: Colors.white,
                appBar: Navbar(title: 'Tambah Data Dhuwit'),
                body: SafeArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InputDropdown(
                          title: "Tipe",
                          hintText: "Pilih tipe",
                          controller: vm.typeController,
                          rightIconPath: AppImages.icDropdown,
                          items: ["Pemasukan", "Pengeluaran"],
                          errorText: vm.typeError,
                          onSelected: (value) {
                            vm.validateForm();
                          },
                        ),
                        const SizedBox(height: 16),

                        InputField(
                          title: "Tanggal",
                          hintText: "Masukkan tanggal pencatatan",
                          controller: vm.dateController,
                          errorText: null,
                          onTap: () {
                            vm.selectDate(context);
                          },
                        ),
                        const SizedBox(height: 16),

                        InputField(
                          title: "Waktu",
                          hintText: "Masukkan waktu pencatatan",
                          controller: vm.timeController,
                          errorText: null,
                          onTap: () {
                            vm.selectTime(context);
                          },
                        ),
                        const SizedBox(height: 16),

                        InputField(
                          title: "Nominal",
                          hintText: "Masukkan nominal pencatatan",
                          controller: vm.nominalController,
                          errorText: vm.nominalError,
                          keyboardType: TextInputType.number,
                          onChanged: vm.onNominalChanged,
                        ),

                        const SizedBox(height: 16),
                        InputField(
                          title: "Keterangan",
                          hintText: "Masukkan keterangan pencatatan",
                          maxLines: 3,
                          minLines: 3,
                          controller: vm.descriptionController,
                          errorText: vm.informationError,
                          onChanged: (_) => {vm.validateForm()},
                        ),
                        const SizedBox(height: 24),

                        if (vm.idDhuwit == null) ...[
                          PrimaryButton(
                            text: "Simpan",
                            isEnabled: true,
                            onPressed: () {
                              vm.validateData();
                            },
                          ),
                        ] else ...[
                          PrimaryButton(
                            text: "Update",
                            isEnabled: true,
                            onPressed: () {
                              vm.validateData();
                            },
                          ),
                          const SizedBox(height: 16),
                          SecondaryButton(
                            text: "Hapus",
                            isEnabled: true,
                            onPressed: () {
                              showConfirmBottomSheet(
                                context: context,
                                title: 'Hapus Data',
                                message:
                                    'Anda akan menghapus data ini secara permanen. Setelah dihapus, data tidak dapat dikembalikan. Apakah Anda yakin ingin melanjutkan?',
                                negativeText: 'Batal',
                                positiveText: 'Hapus',
                                onPositive: () async {
                                  vm.daleteDhuwit();
                                },
                              );
                            },
                          ),
                        ],
                      ],
                    ),
                  ),
                ) /*  */,
                bottomNavigationBar: Container(
                  color: Colors.transparent,
                  padding: EdgeInsets.fromLTRB(
                    16,
                    16,
                    16,
                    16 + MediaQuery.of(context).padding.bottom,
                  ),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                  ],
                ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
