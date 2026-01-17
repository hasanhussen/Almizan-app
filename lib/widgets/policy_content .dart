import 'package:almizan/cubit/policy_cubit.dart';
import 'package:almizan/general/color.dart';
import 'package:almizan/state/policy_state.dart';
import 'package:almizan/views/app_info/policy_and_privacy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PolicyContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 145),
      child: SingleChildScrollView(
        child: BlocBuilder<PolicyCubit, PolicyState>(
          builder: (context, state) {
            String title = PolicyAndPrivacy.fallbackTitle;
            String body = PolicyAndPrivacy.fallbackBody;

            // 🟡 حالة التحميل
            if (state is PolicyLoading) {
              return const Padding(
                padding: EdgeInsets.only(top: 100),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            // 🔴 حالة الخطأ
            if (state is PolicyError) {
              return Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline,
                        color: Colors.red, size: 50),
                    const SizedBox(height: 12),
                    const Text(
                      'حدث خطأ أثناء تحميل المعلومات',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Tajawal',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        PolicyCubit.get(context).fetchPolicy();
                      },
                      child: const Text('إعادة المحاولة'),
                    ),
                  ],
                ),
              );
            }

            if (state is PolicyLoaded) {
              title = PolicyCubit.get(context).title.isNotEmpty
                  ? PolicyCubit.get(context).title
                  : title;
              body = PolicyCubit.get(context).body.isNotEmpty
                  ? PolicyCubit.get(context).body
                  : body;
            }

            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      color: primary,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Tajawal',
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    body,
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Tajawal',
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
