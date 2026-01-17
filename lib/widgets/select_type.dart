import 'package:flutter/material.dart';
import 'package:almizan/models/question_type.dart';
import 'package:almizan/models/subjects.dart';
import 'package:almizan/models/type.dart';

class SelectTypeWidget extends StatefulWidget {
  /// [onSelect] callBack to handle the Selected subjects
  final Function onSelect;
  int value;
  String name;
  bool isSlected;

  /// List of subjects of type `subjectInWeek`
  List<Types> Subjects;

  /// [backgroundColor] - property to change the color of the container.
  final Color? backgroundColor;

  /// [fontWeight] - property to change the weight of selected text
  final FontWeight? fontWeight;

  /// [fontSize] - property to change the size of selected text
  final double? fontSize;

  /// [subjectsFillColor] -  property to change the button color of subjects when the button is pressed.
  final Color? subjectsFillColor;

  /// [subjectsBorderColor] - property to change the bordercolor of the rounded buttons.
  final Color? subjectsBorderColor;

  /// [selectedSubjectTextColor] - property to change the color of text when the subject is selected.
  final Color? selectedSubjectTextColor;

  /// [unSelectedsubjectTextColor] - property to change the text color when the subject is not selected.
  final Color? unSelectedsubjectTextColor;

  /// [border] Boolean to handle the subject button border by default the border will be true.
  final bool border;

  /// [boxDecoration] to handle the decoration of the container.
  final BoxDecoration? boxDecoration;

  /// [padding] property  to handle the padding between the container and buttons by default it is 8.0
  final double padding;

  /// `SelectWeeksubjects` takes a list of subjects of type `subjectInWeek`.
  /// `onSelect` property will return `list` of subjects that are selected.
  SelectTypeWidget({
    required this.value,
    required this.name,
    required this.onSelect,
    required this.isSlected,
    this.backgroundColor,
    this.fontWeight,
    this.fontSize,
    this.subjectsFillColor,
    this.subjectsBorderColor,
    this.selectedSubjectTextColor,
    this.unSelectedsubjectTextColor,
    this.border = true,
    this.boxDecoration,
    this.padding = 8.0,
    required this.Subjects,
    Key? key,
  }) : super(key: key);

  @override
  _SelectSubjectsWidgetState createState() => _SelectSubjectsWidgetState();
}

class _SelectSubjectsWidgetState extends State<SelectTypeWidget> {
  @override
  Color? get _handleBackgroundColor {
    if (widget.backgroundColor == null) {
      return Theme.of(context).dialogBackgroundColor;
      // return Theme.of(context).accentColor;
    } else {
      return widget.backgroundColor;
    }
  }

// getter to handle fill color of buttons.
  Color? get _handlesubjectsFillColor {
    if (widget.subjectsFillColor == null) {
      return Colors.white;
    } else {
      return widget.subjectsFillColor;
    }
  }

//getter to handle border color of subjects[buttons].
  Color? get _handleBorderColorOfsubjects {
    if (widget.subjectsBorderColor == null) {
      return Colors.white;
    } else {
      return widget.subjectsBorderColor;
    }
  }

// Handler to change the text color when the button is pressed and not pressed.
  Color? _handleTextColor(bool onSelect) {
    if (onSelect == true) {
      if (widget.selectedSubjectTextColor == null) {
        return Colors.black;
      } else {
        return widget.selectedSubjectTextColor;
      }
    } else if (onSelect == false) {
      if (widget.unSelectedsubjectTextColor == null) {
        return Colors.white;
      } else {
        return widget.unSelectedsubjectTextColor;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: widget.isSlected == true ? _handlesubjectsFillColor : null,
      ),
      width: double.infinity,
      height: 70,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 50,
            height: 50,
            margin: const EdgeInsets.only(right: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(width: 3, color: Colors.white),
              image: const DecorationImage(
                  image: AssetImage("assets/img/logo_app.png"),
                  fit: BoxFit.cover),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.name,
                  style: TextStyle(
                      color: _handleTextColor(widget.isSlected),
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                Row(
                  children: <Widget>[
                    Text('Number of Question',
                        style: TextStyle(
                            color: _handleTextColor(widget.isSlected),
                            fontSize: 13,
                            letterSpacing: .3)),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(widget.Subjects[widget.value].questionCount.toString(),
                        style: TextStyle(
                            color: _handleTextColor(widget.isSlected),
                            fontSize: 13,
                            letterSpacing: .3)),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
