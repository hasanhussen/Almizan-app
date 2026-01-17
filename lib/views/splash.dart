import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:almizan/cubit/splash_cubit.dart';
import 'package:almizan/general/color.dart';
import 'package:almizan/state/splash_state.dart';
import 'package:almizan/widgets/Loader.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
            color: Colors.white,
            height: height,
            width: width,
            child: BlocProvider(
                create: (context) {
                  SplashCubit cubit = SplashCubit();
                  cubit.startApp(context);
                  return cubit;
                },
                child: BlocConsumer<SplashCubit, SplashState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      return Column(
                        children: [
                          Container(
                            width: width,
                            height: width,
                            alignment: Alignment.center,
                            child: Center(
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 80,
                                  ),
                                  Image.asset(
                                    "assets/img/logo_app.png",
                                    width: 150,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Image.asset(
                                    "assets/img/golden.png",
                                    color: primary,
                                    width: 150,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Expanded(child: LoaderTwo())
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }))));
  }
}
