import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:almizan/general/color.dart';

class CustomTextField extends StatelessWidget {
  final String? hint;
  final TextEditingController controller;
  final Function validator;
  final TextInputType? textInputType;
  final Border? border;
  final EdgeInsets? margin;
  final TextDirection? direction;
  final Function? onChangedCountryCode;
  final bool? showPass;
  final Color? hinColor;
  final Function? onShowPass;
  final Function? onChanged;
  final String? title;
  final Widget? suffixIcon;
  const CustomTextField({
    Key? key,
    this.hint,
    this.hinColor,
    required this.controller,
    required this.validator,
    this.textInputType,
    this.border,
    this.margin,
    this.onChangedCountryCode,
    this.showPass,
    this.onShowPass,
    this.direction,
    this.onChanged,
    this.title,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: direction ?? Directionality.of(context),
      child: Container(
        padding: const EdgeInsets.all(4.0),
        margin: margin ?? const EdgeInsets.all(0.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          children: [
            if (title != null)
              Row(
                mainAxisAlignment: (direction == TextDirection.ltr)
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                children: [
                  Text(
                    title!,
                    style:
                        TextStyle(color: primary, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  borderRadius:
                      border == null ? null : BorderRadius.circular(4),
                  border: border ?? null,
                  color: Colors.grey.shade100),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (textInputType == TextInputType.phone)
                    Container(
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(color: primary.withOpacity(.7)),
                        ),
                      ),
                      child: CountryCodePicker(
                        padding: const EdgeInsets.all(0),
                        flagWidth: 18,
                        showDropDownButton: true,
                        dialogTextStyle:
                            const TextStyle(color: Colors.black, fontSize: 18),
                        textStyle:
                            const TextStyle(color: Colors.black, fontSize: 18),
                        onChanged: (code) {
                          if (onChangedCountryCode != null) {
                            onChangedCountryCode!(code.dialCode);
                          }
                        },
                        boxDecoration: const BoxDecoration(
                          color: Colors.white,
                        ),

                        initialSelection: 'JO',
                        favorite: const [
                          'JO',
                        ],
                        showCountryOnly: false,
                        showOnlyCountryWhenClosed: false,
                        //hideMainText: true,
                      ),
                    ),
                  Expanded(
                    child: TextFormField(
                      controller: controller,
                      validator: (value) {
                        return validator(value);
                      },
                      onChanged: (text) {
                        if (onChanged != null) {
                          onChanged!(text);
                        }
                      },
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      keyboardType: textInputType ?? TextInputType.text,
                      obscureText: !(showPass ?? true),
                      decoration: InputDecoration(
                        suffixIcon: suffixIcon,
                        hintText: hint,
                        enabledBorder: (border != null)
                            ? InputBorder.none
                            : UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: primary.withOpacity(.7)),
                              ),
                        hintStyle: TextStyle(
                          color: hinColor ?? Colors.black54,
                        ),
                      ),
                    ),
                  ),
                  if (textInputType == TextInputType.visiblePassword)
                    IconButton(
                      onPressed: () {
                        if (onShowPass != null) {
                          onShowPass!(!showPass!);
                        }
                      },
                      icon: Icon(
                        Icons.visibility_outlined,
                        color: (!(showPass ?? true))
                            ? Colors.black
                            : Colors.grey[300]!,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
