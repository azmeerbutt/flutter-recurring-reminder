import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reccuring_reminder/common/values/colors.dart';
import 'package:flutter_reccuring_reminder/common/values/constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

Widget buildHeadingText({required String title}) {
  return Text(
    title,
    style: TextStyle(
      color: AppColors.mainTheme,
      fontSize: 20.sp,
      fontWeight: FontWeight.bold,
    ),
  );
}

Widget buildTaskField({required Function(String)? onChanged}) {
  return TextFormField(
    onChanged: onChanged,
    minLines: 2,
    maxLines: 4,
    keyboardType: TextInputType.multiline,
    decoration: InputDecoration(
      hintText: 'Enter Task Here',
      hintStyle: const TextStyle(color: Colors.grey),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.mainTheme, width: 2.0.w),
        borderRadius: BorderRadius.circular(16.0.w),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(16.0.w)),
      ),
    ),
  );
}

Widget buildDateTimePicker(
    {required BuildContext context,
    required void Function(DateTime?) onDateTimeChanged}) {
  return Container(
    height: 100.h,
    decoration: BoxDecoration(
      border: Border(
        top: BorderSide(
          color: AppColors.mainTheme,
          width: 2.w,
        ),
        bottom: BorderSide(
          color: AppColors.mainTheme,
          width: 2.w,
        ),
        left: BorderSide(
          color: AppColors.mainTheme,
          width: 2.w,
        ),
        right: BorderSide(
          color: AppColors.mainTheme,
          width: 2.w,
        ),
      ),
      borderRadius: BorderRadius.all(Radius.circular(16.0.w)),
    ),
    child: CupertinoDatePicker(
      mode: CupertinoDatePickerMode.dateAndTime,
      minimumDate: DateTime.now().subtract(const Duration(days: 0)),
      initialDateTime: DateTime.now(),
      onDateTimeChanged: onDateTimeChanged,
      use24hFormat: false,
      minuteInterval: 1,
    ),
  );
}

Widget buildDropDown(
    {required BuildContext context,
    required String selectedValue,
    required String inital,
    required List<String> dropDownList,
    required Function(String?)? onChanged}) {
  return DropdownButton(
    hint: Text(
      selectedValue,
    ),
    isExpanded: true,
    iconSize: 30.0.w,
    dropdownColor: AppColors.mainTheme,
    iconEnabledColor: AppColors.mainTheme,
    // borderRadius: BorderRadius.circular(16.0),
    style: TextStyle(color: Colors.white, fontSize: 18.sp),
    items: dropDownList.map(
      (val) {
        return DropdownMenuItem<String>(
          value: val,
          child: Text(val),
        );
      },
    ).toList(),
    onChanged: onChanged,
  );
}

Widget buildDurationText(String? duration) {
  String? intervalText;
  if (duration == AppConstant.RECURRENCE[1]) {
    intervalText = 'Every hour from now on';
  }
  if (duration == AppConstant.RECURRENCE[2]) {
    intervalText = 'Every day from today';
  }
  if (duration == AppConstant.RECURRENCE[3]) {
    intervalText =
        'Every ${DateFormat('EEEE').format(DateTime.now())} of the week';
  }
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      buildHeadingText(title: 'Repeat :'),
      Row(
        children: [
          Icon(
            Icons.repeat_on,
            color: Colors.green,
            size: 18.w,
          ),
          SizedBox(
            width: 5.0.w,
          ),
          buildAlarmText(text: intervalText),
        ],
      ),
    ],
  );
}

Widget buildAlarmText({String? text}) {
  return Text(
    text ?? '',
    style: TextStyle(
      color: Colors.green,
      fontSize: 18.w,
    ),
  );
}
