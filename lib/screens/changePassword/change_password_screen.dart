import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship/core/widgets/show_toast.dart';
import 'package:internship/screens/changePassword/cubit/change_password_cubit.dart';
import 'package:internship/screens/changePassword/cubit/change_password_cubit_states.dart';
import 'package:internship/widgets/background_linear_gradient.dart';
import 'package:internship/widgets/custom_elevated_button.dart';
import 'package:internship/widgets/header_widget.dart';
import 'package:internship/widgets/loading.dart';
import 'package:internship/widgets/main_content_widget.dart';
import 'package:internship/widgets/space_height.dart';
import 'package:internship/widgets/text_field_global_widget.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});
  static const String routeName = '/change-password-screen';

  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        child: Stack(
          children: [
            const BackgroundLinearGradient(),
            MainContentWidget(
              size: size,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const HeaderWidget(
                      icon: Icons.lock,
                      text: 'Change Password',
                    ),
                    const SpaceHeight(),
                    TextFormFieldGlobalWidget(
                      controller: _oldPasswordController,
                      text: 'Old Password',
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Please Fill The Field';
                        }
                        return null;
                      },
                    ),
                    const SpaceHeight(),
                    TextFormFieldGlobalWidget(
                      controller: _newPasswordController,
                      text: 'New Password',
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Please Fill The Field';
                        }
                        return null;
                      },
                    ),
                    const SpaceHeight(),
                    BlocConsumer<ChangePasswordCubit, ChangePasswordStates>(
                        listener: (context, state) {
                      if (state is ChnagePasswordSuccessState) {
                        showToast(
                            'Password Changed Successfully', Colors.green);
                      } else if (state is ChangePasswordErrorState) {
                        showToast(state.message, Colors.red);
                      }
                    }, builder: (context, state) {
                      if (state is ChangePasswordLoadingState) {
                        return const Loading();
                      }
                      return MyCustomButton(
                        height: 40,
                        width: 200,
                        text: 'Change Password',
                        onPress: () {
                          bool isValid = _formKey.currentState!.validate();
                          if (isValid) {
                            BlocProvider.of<ChangePasswordCubit>(context)
                                .changeUserPassword(_oldPasswordController.text,
                                    _newPasswordController.text);

                            FocusScope.of(context).unfocus();
                          }
                        },
                        borderRadius: BorderRadius.circular(10),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
