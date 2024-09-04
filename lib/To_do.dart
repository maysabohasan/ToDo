import 'package:flutter/material.dart';

class ToDo extends StatefulWidget {
  const ToDo({super.key});

  @override
  State createState() => _ToDoState();
}

class _ToDoState extends State<ToDo> {
  bool _isDarkTheme = false;
  final List<Map<String, dynamic>> _tasks = [
    {'task': 'Task 1', 'completed': false},
    {'task': 'Task 2', 'completed': false},
    {'task': 'Task 3', 'completed': false},
  ];
  final List<Map<String, dynamic>> _deletedTasks = [];
  List<Map<String, dynamic>> _filterTasks = [];
  int _selectedIndex = 0;
  final TextEditingController _taskController = TextEditingController();
  bool _newTaskCompleted = false;
  int? _selectedTaskIndex;

  @override
  void initState() {
    super.initState();
    _filterTasks = _tasks;
  }

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _isDarkTheme ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                _isDarkTheme ? 'images/MD.jpg' : 'images/ML.jpg',
                fit: BoxFit.cover,
                height: 280,
              ),
            ),
            Positioned.fill(
              child: Container(
                color: _isDarkTheme
                    ? Colors.black54
                    : Colors.grey.withOpacity(0.34),
                child: Column(
                  children: [
                    const SizedBox(height: 140),
                    _buildTaskInput(),
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.92,
                            maxHeight: MediaQuery.of(context).size.height * 0.5,
                          ),
                          decoration: BoxDecoration(
                            color:
                                _isDarkTheme ? Colors.grey[850] : Colors.white,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: _buildTaskList(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    _buildFilterButtons(),
                    const SizedBox(height: 30),
                    Text(
                      'Drag and drop reorder list ',
                      style: TextStyle(
                        color: _isDarkTheme ? Colors.grey : Colors.black38,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 60,
              right: 16,
              child: FloatingActionButton(
                backgroundColor: Colors.transparent,
                elevation: 0,
                shape: const CircleBorder(),
                child: Icon(
                  _isDarkTheme ? Icons.wb_sunny : Icons.nightlight_round,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    _isDarkTheme = !_isDarkTheme;
                  });
                },
              ),
            ),
            const Positioned(
              top: 60,
              left: 30,
              child: Text(
                "T O  D O",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskInput() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          TextField(
            controller: _taskController,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 48.0),
              hintText: 'Create a new todo...',
              hintStyle: TextStyle(
                color: Colors.grey[500],
                fontSize: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: _isDarkTheme ? Colors.grey[800] : Colors.grey[200],
            ),
            style: TextStyle(color: _isDarkTheme ? Colors.white : Colors.black),
            onSubmitted: _addTask,
          ),
          Positioned(
            left: 0,
            top: 1,
            child: Radio(
              activeColor: Colors.purple[900],
              value: 0,
              groupValue: _selectedTaskIndex,
              onChanged: (int? value) {
                setState(() {
                  _selectedTaskIndex = value;
                  _newTaskCompleted = value == 0;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskList() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: _filterTasks.length,
            itemBuilder: (context, index) {
              final task = _filterTasks[index];
              return Column(
                children: [
                  ListTile(
                    title: Text(
                      task['task'],
                      style: TextStyle(
                        decoration: task['completed']
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        color: task['completed']
                            ? Colors.grey
                            : (_isDarkTheme ? Colors.white : Colors.black),
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.close,
                        color: _isDarkTheme ? Colors.white : Colors.black,
                      ),
                      onPressed: () => _updateTask(index, 'delete'),
                    ),
                    leading: Radio(
                      value: index,
                      groupValue: _selectedTaskIndex,
                      onChanged: (int? value) {
                        setState(() {
                          _selectedTaskIndex = value;
                          task['completed'] = value == index;
                          _updateFilteredTasks();
                        });
                      },
                    ),
                  ),
                  if (index < _filterTasks.length - 1)
                    Divider(
                      color: _isDarkTheme ? Colors.white : Colors.grey,
                      thickness: 0.5,
                    ),
                ],
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${_tasks.where((task) => !task['completed']).length} items left',
                style: TextStyle(
                  color: _isDarkTheme ? Colors.grey : Colors.grey,
                ),
              ),
              if (_selectedIndex == 2)
                GestureDetector(
                  onTap: _clearCompletedTasks,
                  child: Text(
                    'Clear completed',
                    style: TextStyle(
                      color: _isDarkTheme ? Colors.white : Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              else if (_selectedIndex == 0 || _selectedIndex == 1)
                const Text(
                  'Clear completed',
                  style: TextStyle(color: Colors.grey),
                )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: _isDarkTheme ? Colors.grey[800] : Colors.white,
            borderRadius: BorderRadius.circular(6)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildFilterButton(0, 'All'),
            const SizedBox(width: 5.0),
            _buildFilterButton(1, 'Active'),
            const SizedBox(width: 5.0),
            _buildFilterButton(2, 'Completed'),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButton(int index, String label) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
          _updateFilteredTasks();
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Text(
          label,
          style: TextStyle(
            color: _selectedIndex == index
                ? Colors.blue
                : (_isDarkTheme ? Colors.grey : Colors.grey),
            fontSize: 16,
            fontWeight:
                _selectedIndex == index ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  void _addTask(String value) {
    if (value.isNotEmpty) {
      setState(() {
        _tasks.add({'task': value, 'completed': _newTaskCompleted});
        _updateFilteredTasks();
        _taskController.clear();
        _newTaskCompleted = false;
      });
    }
  }

  void _updateTask(int index, String action) {
    setState(() {
      final task = _filterTasks[index];
      if (action == 'delete') {
        _deletedTasks.add(task);
        _tasks.removeWhere((t) => t['task'] == task['task']);
        _filterTasks.removeAt(index);
      }
      _updateFilteredTasks();
    });
  }

  void _updateFilteredTasks() {
    switch (_selectedIndex) {
      case 1:
        _filterTasks = _tasks.where((task) => !task['completed']).toList();
        break;
      case 2:
        _filterTasks = _tasks.where((task) => task['completed']).toList();
        break;
      default:
        _filterTasks = _tasks;
    }
  }

  void _clearCompletedTasks() {
    setState(() {
      _tasks.removeWhere((task) => task['completed']);
      _updateFilteredTasks();
    });
  }
}

class DeletedTasksPage extends StatelessWidget {
  final List<Map<String, dynamic>> deletedTasks;

  const DeletedTasksPage({super.key, required this.deletedTasks});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Deleted Tasks')),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: deletedTasks.length,
        itemBuilder: (context, index) {
          final task = deletedTasks[index];
          return Card(
            child: Center(
              child: Text(
                task['task'],
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          );
        },
      ),
    );
  }
}
