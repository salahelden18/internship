import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship/core/global/colors.dart';
import 'package:internship/core/widgets/show_toast.dart';
import 'package:internship/screens/auth/cubit/auth_cubit.dart';
import 'package:internship/screens/auth/cubit/auth_states.dart';
import 'package:internship/widgets/custom_elevated_button.dart';
import 'package:internship/widgets/loading.dart';
import 'package:internship/widgets/auth/text_form_field_widget.dart';

enum Authentication { signin, signup }

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Authentication authentication = Authentication.signin;

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/images/login.png',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.35,
                    width: size.width,
                    child: Image.asset('assets/images/logo.png'),
                  ),
                  const SizedBox(height: 10),
                  AnimatedBuilder(
                    animation: _animationController,
                    child: Container(
                      height: 368,
                      width: 326,
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      decoration: BoxDecoration(
                        color: const Color(0xffFBCD05).withOpacity(0.40),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(300),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 30,
                          right: 60,
                          left: 20,
                          bottom: 10,
                        ),
                        child: _buildTheMainContent(context),
                      ),
                    ),
                    builder: (context, child) => SlideTransition(
                      position: Tween(
                        begin: const Offset(0, 0.3),
                        end: const Offset(0, 0),
                      ).animate(
                        CurvedAnimation(
                          parent: _animationController,
                          curve: Curves.easeInOut,
                        ),
                      ),
                      child: child,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column _buildTheMainContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Text(
              authentication == Authentication.signin ? 'Login' : 'Register',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: thirdColor,
                  ),
            ),
            const Icon(
              Icons.person_2_outlined,
              color: thirdColor,
              size: 40,
            ),
          ],
        ),
        const SizedBox(height: 10),
        TextFormFieldWidget(
          hintText: 'Enter Your Email',
          controller: _emailController,
          validator: (val) {
            if (val!.isEmpty) {
              return 'Please Enter Your Email';
            }
            return null;
          },
          icon: Icons.email,
        ),
        const SizedBox(height: 10),
        if (authentication == Authentication.signin)
          TextFormFieldWidget(
            hintText: 'Enter Your Password',
            controller: _passwordController,
            validator: (val) {
              if (val!.isEmpty) {
                return 'Please Enter Your Password';
              }
              return null;
            },
            isPass: true,
            icon: Icons.lock,
          ),
        const SizedBox(height: 10),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton(
            onPressed: () {
              setState(() {
                authentication = authentication == Authentication.signin
                    ? Authentication.signup
                    : Authentication.signin;
              });
            },
            style: TextButton.styleFrom(),
            child: Text(
              authentication == Authentication.signin ? 'Register?' : 'Login?',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ),
        const SizedBox(height: 10),
        BlocConsumer<AuthCubit, AuthStates>(listener: (context, state) {
          if (state is AuthenticateErrorState) {
            showToast(state.message, Colors.red);
          } else if (state is RegisteredSuccessfullyState) {
            showToast(state.message, Colors.green);
            setState(() {
              authentication = authentication == Authentication.signin
                  ? Authentication.signup
                  : Authentication.signin;
            });
          }
        }, builder: (context, state) {
          if (state is AuthLoginLoadingState) {
            return const Loading();
          }
          return MyCustomButton(
            height: 40,
            width: 150,
            text: authentication == Authentication.signin ? 'Login' : 'Sign Up',
            borderRadius: BorderRadius.circular(5),
            onPress: () {
              bool isValid = _formKey.currentState!.validate();
              if (isValid) {
                if (authentication == Authentication.signup) {
                  BlocProvider.of<AuthCubit>(context)
                      .signup(_emailController.text);
                } else {
                  BlocProvider.of<AuthCubit>(context)
                      .login(_emailController.text, _passwordController.text);
                }
              }
            },
          );
        })
      ],
    );
  }
}
