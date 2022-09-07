import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer_course/src/config/custom_colors.dart';
import 'package:greengrocer_course/src/pages/auth/controller/auth_controller.dart';
import 'package:greengrocer_course/src/pages/common_widgets/custom_text_field.dart';
import 'package:greengrocer_course/src/config/app_data.dart' as app_data;
import 'package:greengrocer_course/src/services/validators.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

final authController = Get.find<AuthController>();

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil do usuário'),
        actions: [
          IconButton(
              onPressed: () {
                authController.signOut();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
        children: [
          CustomTextField(
              readOnly: true,
              initialValue: authController.user.email,
              icon: Icons.email,
              label: 'Email'),
          CustomTextField(
              readOnly: true,
              initialValue: authController.user.name,
              icon: Icons.person,
              label: 'Nome'),
          CustomTextField(
              readOnly: true,
              initialValue: authController.user.phone,
              icon: Icons.phone,
              label: 'Celular'),
          CustomTextField(
              readOnly: true,
              initialValue: authController.user.cpf,
              icon: Icons.file_copy,
              label: 'CPF',
              isSecret: true),
          SizedBox(
            height: 45,
            child: OutlinedButton(
                onPressed: updatePassword,
                style: OutlinedButton.styleFrom(
                    side: BorderSide(color: CustomColors.customPrimaryColor),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                child: const Text('Atualizar Senha')),
          )
        ],
      ),
    );
  }

  Future<bool?> updatePassword() {
    final newPasswordController = TextEditingController();
    final currentpassowrdCOntroller = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: SingleChildScrollView(
              reverse: true,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Text('Atualização de senha',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                          ),
                          CustomTextField(
                            icon: Icons.lock,
                            label: 'Senha Atual',
                            isSecret: true,
                            validator: passwordValidator,
                            controller: currentpassowrdCOntroller,
                          ),
                          CustomTextField(
                            controller: newPasswordController,
                            icon: Icons.lock_outline,
                            label: 'Nova Senha',
                            isSecret: true,
                            validator: passwordValidator,
                          ),
                          CustomTextField(
                            icon: Icons.lock_outline,
                            label: 'Confirmar nova senha',
                            isSecret: true,
                            validator: (passowrd) {
                              final result = passwordValidator(passowrd);

                              if (result != null) {
                                return result;
                              }

                              if (passowrd != newPasswordController.text) {
                                return 'As senha não são iguais';
                              }

                              return null;
                            },
                          ),
                          SizedBox(
                            height: 45,
                            child: Obx(() => ElevatedButton(
                                onPressed: authController.isLoading.value ? null : () {
                                  if(_formKey.currentState!.validate()) {
                                    authController.changePassword(
                                      currentPassword: currentpassowrdCOntroller.text, 
                                      newPassword: newPasswordController.text
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18))),
                                child: authController.isLoading.value ? const CircularProgressIndicator() : const Text('Atualizar'))),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      top: 12.5,
                      right: 5,
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.close),
                      ))
                ],
              ),
            ),
          );
        });
  }
}
