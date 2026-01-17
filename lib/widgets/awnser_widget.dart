import 'package:flutter/material.dart';
import 'package:almizan/core/app_colors.dart';
import 'package:almizan/general/color.dart';
import 'package:almizan/models/answer.dart';

import '../core/core.dart';

class AwnserWidget extends StatelessWidget {
  final Answers awnser;
  final bool isSelected;
  final ValueChanged<bool> onTap;
  final bool disabled;
  final bool isSubmited;

  const AwnserWidget({
    Key? key,
    required this.awnser,
    this.isSelected = false,
    required this.onTap,
    this.disabled = false,
    this.isSubmited = false,
  }) : super(key: key);

  Color get _selectedColorRight => isSubmited
      ? awnser.isCorrect == 1
          ? AppColors.darkGreen
          : AppColors.darkRed
      : primary;

  Color get _selectedBorderRight => isSubmited
      ? awnser.isCorrect == 1
          ? AppColors.lightGreen
          : AppColors.lightRed
      : primary;

  Color get _selectedColorCardRight => isSubmited
      ? awnser.isCorrect == 1
          ? AppColors.lightGreen
          : AppColors.lightRed
      : primary;

  Color get _selectedBorderCardRight => isSubmited
      ? awnser.isCorrect == 1
          ? AppColors.green
          : AppColors.red
      : primary;

  TextStyle get _selectedTextStyleRight => isSubmited
      ? awnser.isCorrect == 1
          ? AppTextStyles.bodyDarkGreen
          : AppTextStyles.bodyDarkRed
      : AppTextStyles.body11;

  IconData get _selectedIconRight => isSubmited
      ? awnser.isCorrect == 1
          ? Icons.check
          : Icons.close
      : Icons.circle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: IgnorePointer(
        ignoring: disabled,
        child: GestureDetector(
          onTap: () {
            onTap(awnser.isCorrect == 1);
          },
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: isSelected ? _selectedColorCardRight : AppColors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.fromBorderSide(
                  BorderSide(
                    color: isSelected
                        ? _selectedBorderCardRight
                        : awnser.isCorrect == 1
                            ? disabled
                                ? AppColors.green
                                : AppColors.border
                            : AppColors.border,
                  ),
                )),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        awnser.answerText!,
                        style: isSelected
                            ? _selectedTextStyleRight
                            : awnser.isCorrect == 1
                                ? disabled
                                    ? AppTextStyles.bodyDarkGreen
                                    : AppTextStyles.body
                                : AppTextStyles.body,
                      ),
                    ),
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? _selectedColorRight
                            : awnser.isCorrect == 1
                                ? disabled
                                    ? AppColors.darkGreen
                                    : AppColors.white
                                : AppColors.white,
                        borderRadius: BorderRadius.circular(500),
                        border: Border.fromBorderSide(
                          BorderSide(
                              color: isSelected
                                  ? _selectedBorderRight
                                  : awnser.isCorrect == 1
                                      ? disabled
                                          ? AppColors.lightGreen
                                          : AppColors.border
                                      : AppColors.border),
                        ),
                      ),
                      child: isSelected
                          ? Icon(
                              _selectedIconRight,
                              color: AppColors.white,
                              size: 16,
                            )
                          : awnser.isCorrect == 1
                              ? disabled
                                  ? Icon(
                                      Icons.check,
                                      color: AppColors.green,
                                      size: 16,
                                    )
                                  : null
                              : null,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
