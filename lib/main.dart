import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

enum TaskEvent { add, delete }

class TaskBloc extends Bloc<TaskEvent, List<String>> {
  TaskBloc() : super([]) {
    on<TaskEvent>((event, emit) {
      if (event == TaskEvent.add) {
        emit([...state, 'Tarea ${state.length + 1}']);
      } else if (event == TaskEvent.delete) {
        if (state.isNotEmpty) {
          emit(state.take(state.length - 1).toList());
        }
      }
    });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _taskBloc = TaskBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _taskBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Bloc Demo'),
          actions: [
            BlocBuilder<TaskBloc, List<String>>(
              builder: (context, tasks) {
                return Center(
                  child: Text(
                    '${tasks.length} Tareas',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                );
              },
            )
          ],
        ),
        body: BlocBuilder<TaskBloc, List<String>>(
          builder: (context, tasks) {
            if (tasks.isEmpty) {
              return const Center(child: Text('No Tareas'));
            }
            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(tasks[index]),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      _taskBloc.add(TaskEvent.delete);
                    },
                  ),
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _taskBloc.add(TaskEvent.add);
          },
          tooltip: 'Anadir Tarea',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _taskBloc.close();
    super.dispose();
  }
}
