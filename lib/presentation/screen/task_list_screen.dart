import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_application_tasks/di/di.dart';
import 'package:flutter_application_tasks/domain/task/entity/task.dart';
import 'package:flutter_application_tasks/presentation/bloc/task_list_bloc.dart';
import 'package:flutter_application_tasks/presentation/screen/add_task_screen.dart';
import 'package:flutter_application_tasks/presentation/screen/update_task_screen.dart';
import 'package:flutter_application_tasks/presentation/widget/appbar/my_app_bar.dart';
import 'package:flutter_application_tasks/presentation/widget/button/my_elevated_button.dart';

class TaskListScreen extends StatelessWidget {
  static const routeName = '/main';

  const TaskListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<TaskListBloc>(
          create: (_) => getIt<TaskListBloc>(),
          dispose: (_, bloc) => bloc.dispose(),
        ),
      ],
      child: Consumer<TaskListBloc>(
        builder: (BuildContext context, TaskListBloc tasksBloc, _) {
          return Scaffold(
              appBar: _buildAppBar(context, tasksBloc),
              body: _buildBody(context, tasksBloc));
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(
      BuildContext context, TaskListBloc tasksBloc) {
    return MyAppBar(title: 'Список задач', actions: [
      Row(
        children: <Widget>[
          _deleteTasksWidget(
            context,
            'Удалить все задачи?',
            'Вы уверены, что хотите удалить все задачи?',
            'Удалить все задачи',
            tasksBloc.deleteAllTasks,
          )
        ],
      )
    ]);
  }

  Widget _buildBody(BuildContext context, TaskListBloc tasksBloc) {
    return StreamBuilder<List<TaskEntity>>(
        stream: tasksBloc.tasksStream,
        builder: (context, snapshot) {
          final List<TaskEntity>? tasks = snapshot.data;
          if (tasks == null) {
            return const SizedBox.shrink();
          }
          final List<TaskEntity> incompleteTasks = tasksBloc.incompleteTasks;
          final List<TaskEntity> completedTasks = tasksBloc.completedTasks;
          return Stack(
            children: [
              StreamBuilder<bool>(
                  stream: tasksBloc.collapseFlagStream,
                  builder: (context, snapshot) {
                    final bool? collapsed = snapshot.data;
                    if (collapsed == null) {
                      return const SizedBox.shrink();
                    }
                    const taskPadding = 5.0;
                    return CustomScrollView(slivers: [
                      SliverPadding(
                          padding: const EdgeInsets.all(taskPadding),
                          sliver: _taskListWidget(tasksBloc, incompleteTasks)),
                      if (completedTasks.isNotEmpty)
                        SliverPadding(
                          padding: const EdgeInsets.only(
                              left: taskPadding, right: taskPadding),
                          sliver: _tasksDivider(
                              tasksBloc, completedTasks.length, collapsed),
                        ),
                      if (collapsed == false)
                        SliverPadding(
                          padding: const EdgeInsets.all(taskPadding),
                          sliver: _taskListWidget(tasksBloc, completedTasks),
                        ),
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            SizedBox(
                              height:
                                  70 + MediaQuery.of(context).padding.bottom,
                            ),
                          ],
                        ),
                      ),
                    ]);
                  }),
              Positioned(
                bottom: 10,
                right: 10,
                child: _addTaskButtonWidget(context, tasksBloc),
              ),
            ],
          );
        });
  }

  Widget _deleteTasksWidget(BuildContext context, String titleText,
      String contentText, String messageText, Function deleteFunction) {
    return GestureDetector(
      onTap: () async {
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                titleText,
                textAlign: TextAlign.center,
              ),
              content: Text(contentText),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Отмена'),
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                    await deleteFunction();
                  },
                  child: const Text('Удалить'),
                ),
              ],
            );
          },
        );
      },
      child: Tooltip(
        message: messageText,
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Icon(
            Icons.delete,
            size: 30,
          ),
        ),
      ),
    );
  }

  SliverList _taskListWidget(TaskListBloc tasksBloc, List<TaskEntity> tasks) {
    return SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
      return Dismissible(
        key: Key(tasks[index].id),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) async {
          await tasksBloc.deleteTask(tasks[index].id);
        },
        background: Container(
          color: Colors.red,
          child: const Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
          ),
        ),
        child: Card(
          child: ListTileTheme(
            contentPadding: const EdgeInsets.symmetric(horizontal: 1.0),
            child: ListTile(
              leading: Checkbox(
                value: tasks[index].isCompleted,
                onChanged: (value) async {
                  await tasksBloc.changeTaskStatus(tasks[index]);
                },
              ),
              title: Text(
                '${index + 1}) ${tasks[index].name}',
                style: TextStyle(
                  decoration: tasks[index].isCompleted
                      ? TextDecoration.lineThrough
                      : null,
                ),
              ),
              visualDensity: const VisualDensity(vertical: -4),
              onTap: () async {
                await Navigator.pushNamed(context, UpdateTaskScreen.routeName,
                    arguments: tasks[index]);
              },
            ),
          ),
        ),
      );
    }, childCount: tasks.length));
  }

  SliverList _tasksDivider(
      TaskListBloc tasksBloc, int numbers, bool collapsed) {
    return SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
      return Padding(
        padding: const EdgeInsets.only(left: 4.0),
        child: Row(
          children: <Widget>[
            IconButton(
              onPressed: () {
                tasksBloc.changeCollapseStatus();
              },
              icon: collapsed == true
                  ? const Icon(Icons.arrow_drop_up)
                  : const Icon(Icons.arrow_drop_down),
            ),
            Text(
              'Завершено $numbers',
              style: const TextStyle(fontSize: 16),
            ),
            Expanded(
              child: Container(),
            ),
            _deleteTasksWidget(
                context,
                'Удалить выполненные задачи?',
                'Вы уверены, что хотите удалить все выполненные задачи?',
                'Удалить все выполненные задачи',
                tasksBloc.deleteCompletedTasks),
          ],
        ),
      );
    }, childCount: 1));
  }

  Widget _addTaskButtonWidget(BuildContext context, TaskListBloc tasksBloc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyElevatedButton(
          onPressed: () async {
            await Navigator.pushNamed(context, AddTaskScreen.routeName);
          },
          title: '+',
        ),
      ],
    );
  }
}
