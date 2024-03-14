import 'package:flutter/material.dart';
import 'package:flutter_reccuring_reminder/common/values/constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../common/entities/task.dart';

Widget buildBigText({String? title, Color color = Colors.white}) {
  return Text(
    title!,
    style:
        TextStyle(color: color, fontSize: 20.sp, fontWeight: FontWeight.bold),
  );
}

Widget buidTask(
    {required Task task, bool? done, required void Function(bool?) onChanged}) {
  var text = task.body;
  var repeat = task.recurrence;
  var time = task.dateTime;
  var date = DateTime.fromMillisecondsSinceEpoch(time * 1000);
  bool overdue = DateTime.now().isAfter(date);
  var hours = '${date.hour}:';

  var minute = '${date.minute}';
  if (date.minute < 10) {
    minute = '0${date.minute}';
  }

  var day = '${date.day}/';
  var month = '${date.month}/';
  var year = '${date.year}';
  var dayofweek = DateFormat('EEEE').format(date);

  return Stack(
    alignment: Alignment.center,
    children: [
      Container(
        margin: EdgeInsets.all(10.w),
        padding: EdgeInsets.only(bottom: 10.w, left: 7.w, right: 5.w),
        constraints: const BoxConstraints(
          maxHeight: double.infinity,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.w),
          boxShadow: [
            BoxShadow(
                color: Colors.white.withOpacity(0.5),
                offset: const Offset(0, 10),
                blurRadius: 3,
                spreadRadius: -3),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.w, top: 8.h),
                    child: Text(
                      text,
                      style: TextStyle(fontSize: 18.sp),
                    ),
                  ),
                ),
                Checkbox(value: done, onChanged: onChanged),
              ],
            ),
            SizedBox(
              height: 7.h,
            ),
            repeat != AppConstant.INITIAL_RECURRENCE
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 10.w),
                            child: Text(
                              'Repeat ',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.green,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.repeat,
                            size: 16.w,
                            color: Colors.green,
                          )
                        ],
                      ),
                      repeat == 'Weekly'
                          ? Padding(
                              padding: EdgeInsets.only(right: 14.w),
                              child: Text(
                                'Every $dayofweek At $hours$minute',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.green,
                                ),
                              ),
                            )
                          : repeat == 'Daily'
                              ? Padding(
                                  padding: EdgeInsets.only(right: 14.w),
                                  child: Text(
                                    'Every Day At $hours$minute',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.green,
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding: EdgeInsets.only(right: 14.w),
                                  child: Text(
                                    'Every Hour',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                    ],
                  )
                : overdue
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 10.w),
                            child: Text(
                              'Over Due :  ',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.red,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 14.w),
                            child: Text(
                              '$dayofweek, $day$month$year, $hours$minute',
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 10.w),
                            child: Text(
                              'Due Date :  ',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.green,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 14.w),
                            child: Text(
                              '$dayofweek, $day$month$year, $hours$minute',
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ],
                      ),
          ],
        ),
      ),
    ],
  );
}
