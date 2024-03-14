import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_reccuring_reminder/common/database/task_database.dart';
import 'package:flutter_reccuring_reminder/common/entities/task.dart';
import 'package:flutter_reccuring_reminder/common/values/constant.dart';
import 'package:flutter_reccuring_reminder/pages/home/bloc/home_bloc.dart';
import 'package:flutter_reccuring_reminder/pages/home/home_widgets.dart';
import 'package:flutter_reccuring_reminder/pages/input/input_controller.dart';
import 'package:flutter_reccuring_reminder/pages/input/input_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/values/colors.dart';
import 'bloc/home_state.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Task>? tasks;
  List<Task> nonRepeatingTasks = [];
  List<Task> repeatingTasks = [];
  List<List<Task>>? tasksList = [];
  List<Task> selectedTask = [];
  bool isLoading = false;
  Future refreshTasks() async {
    setState(() => isLoading = true);
    tasks = await TasksDatabase.instance.readAllTasks();
    for (int i = 0; i < tasks!.length; i++) {
      if (tasks![i].recurrence == AppConstant.INITIAL_RECURRENCE) {
        nonRepeatingTasks.add(tasks![i]);
      } else if (tasks![i].recurrence != AppConstant.INITIAL_RECURRENCE) {
        repeatingTasks.add(tasks![i]);
      }
    }
    nonRepeatingTasks.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    tasksList!.add(nonRepeatingTasks);
    tasksList!.add(repeatingTasks);

    setState(() => isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    refreshTasks();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainTheme,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.black,
            height: 1.0.h,
          ),
        ),
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.mainTheme,
        title: const Center(
            child: Text(
          'Tasks',
          style: TextStyle(color: Colors.white),
        )),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
        return isLoading
            ? const Center(child: CircularProgressIndicator())
            : tasks!.isEmpty
                ? const Center(
                    child: Text(
                      'No Tasks',
                      style: TextStyle(color: Colors.grey, fontSize: 24),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: tasksList!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          index == 0
                              ? Container(
                                  alignment: Alignment.centerLeft,
                                  padding:
                                      EdgeInsets.only(left: 10.w, top: 20.h),
                                  child: nonRepeatingTasks.isEmpty
                                      ? const SizedBox(
                                          width: 0,
                                          height: 0,
                                        )
                                      : buildBigText(title: 'SCHEDULED'))
                              : Container(
                                  alignment: Alignment.centerLeft,
                                  padding:
                                      EdgeInsets.only(left: 10.w, top: 30.h),
                                  child: repeatingTasks.isEmpty
                                      ? const SizedBox(
                                          width: 0,
                                          height: 0,
                                        )
                                      : buildBigText(title: 'REPEATED')),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              itemCount: tasksList![index].length,
                              itemBuilder: (BuildContext context, int i) {
                                return buidTask(
                                    task: tasksList![index][i],
                                    done: selectedTask
                                        .contains(tasksList![index][i]),
                                    onChanged: (curValue) {
                                      if (selectedTask
                                          .contains(tasksList![index][i])) {
                                        selectedTask
                                            .remove(tasksList![index][i]);
                                      } else {
                                        selectedTask.add(tasksList![index][i]);
                                      }
                                      InputController(context: context)
                                          .cancelNotification(
                                              tasksList![index][i].id);
                                      TasksDatabase.instance
                                          .delete(tasksList![index][i].id);
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  widget));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                        "Task completed",
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            color: Colors.green),
                                      )));
                                      setState(() {});
                                    });
                              }),
                        ],
                      );
                    },
                  );
      }),
      floatingActionButton: OpenContainer(
        transitionType: ContainerTransitionType.fadeThrough,
        closedElevation: 0.0,
        openElevation: 4.0,
        transitionDuration: const Duration(milliseconds: 1500),
        openBuilder: (BuildContext context, VoidCallback _) =>
            const InputPage(),
        closedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(56.0 / 2),
          ),
        ),
        closedColor: AppColors.mainTheme,
        closedBuilder: (BuildContext context, VoidCallback openContainer) {
          return SizedBox(
            height: 56.0.h,
            width: 56.0.w,
            child: Center(
              child: Icon(
                Icons.add,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
          );
        },
      ),
    );
  }
}
