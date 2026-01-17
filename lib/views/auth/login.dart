import 'package:almizan/views/auth/Reset_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:almizan/views/choose_subject.dart';
import 'package:page_transition/page_transition.dart';
import 'package:almizan/cubit/login_cubit.dart';
import 'package:almizan/general/color.dart';
import 'package:almizan/general/constant.dart';
import 'package:almizan/state/login_state.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);
  void showSnackBar(BuildContext context, String message) {
    SnackBar snackBar = SnackBar(
      content: Text(message),
      backgroundColor: primary,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(milliseconds: 1000),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
    return Scaffold(
        key: _key,
        backgroundColor: Colors.transparent,
        body: BlocProvider(
            create: (BuildContext context) => LoginCubit(),
            child: BlocConsumer<LoginCubit, LoginStates>(
                listener: (context, state) {
              if (state is LoginErrorState) {
                showSnackBar(context, state.error);
              }
            }, builder: (context, state) {
              return Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/img/bg.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  color: primary.withOpacity(0.3),
                  child: Stack(
                    children: [
                      Container(),
                      SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.1),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Image.asset(
                                  "assets/img/logo_app.png",
                                  width: 100,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Align(
                                  alignment: Alignment.center,
                                  child: Image.asset(
                                    "assets/img/golden.png",
                                    width: 150,
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.only(left: 35, right: 35),
                                child: Column(
                                  children: [
                                    TextField(
                                      controller: LoginCubit.get(context)
                                          .userNameController,
                                      style:
                                          const TextStyle(color: Colors.black),
                                      decoration: InputDecoration(
                                          fillColor: Colors.grey.shade100,
                                          filled: true,
                                          hintText: "email",
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          )),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    TextField(
                                      controller: LoginCubit.get(context)
                                          .passwordController,
                                      // style: const TextStyle(),
                                      obscureText: true,
                                      decoration: InputDecoration(
                                          fillColor: Colors.grey.shade100,
                                          filled: true,
                                          hintText: "Password",
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          )),
                                    ),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Login',
                                          style: TextStyle(
                                              color: Color(0xFFFFFFFF),
                                              fontSize: 27,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        CircleAvatar(
                                          radius: 30,
                                          backgroundColor:
                                              const Color(0xFF142B6F),
                                          child: IconButton(
                                              color: Colors.white,
                                              onPressed: () {
                                                LoginCubit.get(context)
                                                    .userLogin(context);
                                              },
                                              icon: const Icon(
                                                Icons.arrow_forward,
                                                color: Colors.white,
                                              )),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  PageTransition(
                                                      type: PageTransitionType
                                                          .leftToRight,
                                                      child: ResetPassword(),
                                                      duration: const Duration(
                                                          microseconds: 800)));
                                            },
                                            child: const Text(
                                              'Forget Password!',
                                              style: TextStyle(
                                                decoration: TextDecoration.none,
                                                color: Color(0xFFFFFFFF),
                                                fontSize: 18,
                                              ),
                                            )),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            })));
  }
}
