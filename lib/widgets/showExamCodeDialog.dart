import 'package:almizan/cubit/question_type_cubit.dart';
import 'package:almizan/state/question_type_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> showExamCodeDialog({
  required BuildContext context,
  required int subjectId,
  required int examId,
  required String subjectName,
}) async {
  final TextEditingController codeController = TextEditingController();

  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) {
      return BlocProvider.value(
        value: QuestionTypeCubit.get(context),
        child: BlocConsumer<QuestionTypeCubit, QuestionTypeState>(
          listener: (context, state) async {
            // if (state is QuestionTypeDone &&
            //     QuestionTypeCubit.get(context).codeValid) {
            //   Navigator.pop(dialogContext); // اغلق الـ Dialog
            //   QuestionTypeCubit.get(context).selectSubject(
            //     subjectId,
            //     examId,
            //     subjectName,
            //     context,
            //   );
            // }
          },
          builder: (context, state) {
            final isLoading = state is QuestionTypeLoading;
            final errorMessage =
                state is QuestionTypeError ? state.message : null;

            return AlertDialog(
              title: const Text('كود الدخول للامتحان'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: codeController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'أدخل كود الامتحان',
                      errorText: errorMessage,
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (isLoading) const CircularProgressIndicator(),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text('إلغاء'),
                ),
                ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () {
                          final code = codeController.text.trim();
                          if (code.isEmpty) {
                            QuestionTypeCubit.get(context)
                                .emitError('الرجاء إدخال الكود');
                            return;
                          }
                          QuestionTypeCubit.get(context).checkExamCode(
                            code,
                            examId,
                            subjectId,
                            examId,
                            subjectName,
                            context,
                          );
                        },
                  child: const Text('دخول'),
                ),
              ],
            );
          },
        ),
      );
    },
  );
}
