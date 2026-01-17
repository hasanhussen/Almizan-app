import 'package:almizan/views/auth/update_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:almizan/general/color.dart';
import 'package:almizan/cubit/reset_password_cubit.dart';
import 'package:almizan/state/reset_password_state.dart';

class VerifyCodeScreen extends StatelessWidget {
  final String email;
  const VerifyCodeScreen({Key? key, required this.email}) : super(key: key);

  void showSnack(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: primary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => ResetPasswordCubit(),
        child: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
          listener: (context, state) {
            if (state is ResetPasswordErrorState) {
              showSnack(context, state.error);
            }
            if (state is ResetPasswordCodeVerifiedState) {
              Navigator.pushReplacement(
                context,
                PageTransition(
                  type: PageTransitionType.leftToRight,
                  child: ResetNewPasswordScreen(email: email),
                ),
              );
            }
          },
          builder: (context, state) {
            return Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/img/bg.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                color: primary.withOpacity(0.3),
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Enter Verification Code',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller:
                              ResetPasswordCubit.get(context).codeController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: 'Verification Code',
                          ),
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primary,
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          onPressed: () {
                            ResetPasswordCubit.get(context)
                                .verifyResetCode(email);
                          },
                          child: const Text(
                            'Verify',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
