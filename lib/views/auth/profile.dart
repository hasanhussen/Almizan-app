import 'package:almizan/general/end_points.dart';
import 'package:almizan/views/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:almizan/cubit/profile_cubit.dart';
import 'package:almizan/state/profile_state.dart';
import '../../general/color.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: const Text("ملفي الشخصي"),
        backgroundColor: primary,
        elevation: 0,
      ),
      body: BlocProvider(
        create: (context) {
          ProfileCubit cubit = ProfileCubit();
          cubit.profileShow();
          return cubit;
        },
        child: BlocBuilder<ProfileCubit, ProfileStates>(
          builder: (context, state) {
            if (state is ProfileLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ProfileErrorState) {
              return Center(
                  child: Text(
                'حدث خطأ أثناء تحميل الملف الشخصي',
                style: TextStyle(color: Colors.red),
              ));
            }

            final cubit = ProfileCubit.get(context);

            return Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 15,
                              offset: Offset(0, 8))
                        ],
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      width: double.infinity,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Header
                          Container(
                            decoration: BoxDecoration(
                              color: primary,
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(14)),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      "Almizan Academy",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      "Official Student Identification",
                                      style: TextStyle(
                                          color: Colors.white70, fontSize: 14),
                                    ),
                                  ],
                                ),
                                // Container(
                                //   padding: const EdgeInsets.symmetric(
                                //       horizontal: 10, vertical: 4),
                                //   decoration: BoxDecoration(
                                //     color: Colors.black87,
                                //     borderRadius: BorderRadius.circular(6),
                                //   ),
                                //   child: Text(
                                //     "STUDENT",
                                //     style: TextStyle(
                                //         color: Colors.white,
                                //         fontWeight: FontWeight.bold),
                                //   ),
                                // ),
                              ],
                            ),
                          ),

                          // Body
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              children: [
                                // الصورة
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    "$imageUrl/${cubit.image}",
                                    width: 70,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 20),

                                // المعلومات
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      infoRow("الاسم", cubit.name ?? ""),
                                      // infoRow("البريد الإلكتروني",
                                      //     cubit.email ?? ""),
                                      infoRow(
                                          "السنة الدراسية", cubit.year ?? ""),
                                      infoRow("رقم الطالب",
                                          cubit.studentId.toString() ?? ""),
                                      infoRow("تاريخ التسجيل",
                                          cubit.registered ?? ""),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 16),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () {
                                  // نفترض انو عندك دالة logout في cubit
                                  ProfileCubit.get(context).logout(
                                      onSuccess: () {
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => const Login()),
                                      (route) => false,
                                    );
                                  });
                                },
                                child: const Text(
                                  "تسجيل خروج",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.w600, color: Colors.grey, fontSize: 12),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  fontSize: 12),
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
