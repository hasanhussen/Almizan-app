import 'package:flutter/material.dart';
import '../general/color.dart';
import '../models/exam.dart';

class SelectExam extends StatelessWidget {
  final int subjectId;
  final String subjectName;
  final List<Exams> exams;
  final void Function()? onTap;

  const SelectExam({
    super.key,
    required this.subjectId,
    required this.subjectName,
    required this.exams,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          /// indicator
          Center(
            child: Container(
              width: 45,
              height: 5,
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

          /// title
          Text(
            'اختر الامتحان',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: blue,
            ),
            textAlign: TextAlign.right,
          ),

          const SizedBox(height: 6),

          Text(
            subjectName,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.right,
          ),

          const SizedBox(height: 20),

          /// exams list
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: exams.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final exam = exams[index];

              return InkWell(
                borderRadius: BorderRadius.circular(18),
                onTap: onTap,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: blue.withOpacity(.2)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.05),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      /// info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              exam.name ?? 'امتحان',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: blue,
                              ),
                              textAlign: TextAlign.right,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '${exam.actualDuration ?? 0} دقيقة',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 12),

                      /// icon
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: blue.withOpacity(.1),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(
                          Icons.quiz,
                          color: Colors.indigo,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
