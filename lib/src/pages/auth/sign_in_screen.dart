import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer_course/src/config/custom_colors.dart';
import 'package:greengrocer_course/src/pages/auth/controller/auth_controller.dart';
import 'package:greengrocer_course/src/pages/common_widgets/app_name_widget.dart';
import 'package:greengrocer_course/src/routes/app_pages.dart';

import '../base/base_screen.dart';
import '../common_widgets/custom_text_field.dart';
import 'sign_up_screen.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: CustomColors.customSwatchColor.shade800,
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            height: size.height,
            width: size.width,
            child: Column(
              children: [
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const AppNameWidget(
                      greenTitleColor: Colors.white,
                      textSize: 40,
                    ),
                    SizedBox(
                      height: 30,
                      child: DefaultTextStyle(
                        style: const TextStyle(fontSize: 25),
                        child: AnimatedTextKit(
                            repeatForever: true,
                            pause: Duration.zero,
                            animatedTexts: [
                              FadeAnimatedText('Frutas'),
                              FadeAnimatedText('Verduras'),
                              FadeAnimatedText('Legumes'),
                              FadeAnimatedText('Carnes'),
                              FadeAnimatedText('Cereais'),
                              FadeAnimatedText('Laticíneos')
                            ]),
                      ),
                    )
                  ],
                )),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(45.0))),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CustomTextField(
                          controller: emailController,
                          icon: Icons.email,
                          label: 'Email',
                          validator: (email) {
                            if (email == null || email.isEmpty)
                              return 'Digite seu E-mail!';

                            if (!email.isEmail)
                              return 'Digite um E-mail válido!';

                            return null;
                          },
                        ),
                        CustomTextField(
                          controller: passwordController,
                          icon: Icons.lock,
                          label: 'Senha',
                          isSecret: true,
                          validator: (password) {
                            if (password == null || password.isEmpty)
                              return 'Digite sua senha!';

                            if (password.length < 7)
                              return 'Digite uma senha com mais de 7 caracteres!';

                            return null;
                          },
                        ),
                        SizedBox(
                          height: 50,
                          child: GetX<AuthController>(
                            builder: (authController) {
                              return ElevatedButton(
                                  onPressed:
                                    authController.isLoading.value 
                                      ? null
                                      : () {

                                        FocusScope.of(context).unfocus();

                                        if (_formKey.currentState!.validate()) {
                                          authController.signIn(
                                            email: emailController.text, 
                                            password: passwordController.text
                                          );
                                        } else {
                                          print('Não validos');
                                        }
                                    // Get.offNamed(PagesRoutes.baseRoute);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18))),
                                  child: authController.isLoading.value 
                                    ? const CircularProgressIndicator() 
                                    : const Text('Entrar',
                                      style: TextStyle(fontSize: 18)));
                            },
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              'Esqueceu a senha?',
                              style: TextStyle(
                                  color: CustomColors.customContrastColor),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  color: Colors.grey.withAlpha(90),
                                  thickness: 2,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Text('OU'),
                              ),
                              Expanded(
                                child: Divider(
                                  color: Colors.grey.withAlpha(90),
                                  thickness: 2,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          child: OutlinedButton(
                              onPressed: () =>
                                  Get.toNamed(PagesRoutes.signUpRoute),
                              style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                      width: 2,
                                      color: CustomColors.customPrimaryColor),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18))),
                              child: const Text('Criar conta',
                                  style: TextStyle(fontSize: 18))),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
