import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:moodtracker/core/models/mood/mood_category.dart';
import 'package:moodtracker/core/widgets/dialog/error_dialog.dart';
import 'package:moodtracker/features/write/view_models/write_view_model.dart';
import 'package:moodtracker/features/write/views/widgets/write_icon_button.dart';
import 'package:moodtracker/route/route_path.dart';

class WriteScreen extends ConsumerStatefulWidget {
  const WriteScreen({super.key});

  @override
  ConsumerState<WriteScreen> createState() => _WriteScreenState();
}

class _WriteScreenState extends ConsumerState<WriteScreen> {
  final TextEditingController _controller = TextEditingController();
  late final WriteViewModel _viewModel = ref.read(writeProvider.notifier);

  MoodCategory? _selectedMood;
  String? _moodErrorMessage;
  String? _textErrorMessage;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        spacing: 16,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: MoodCategory.values.length,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisExtent: 60,
                ),
                itemBuilder: (context, index) {
                  final mood = MoodCategory.fromIndex(index);
                  return WriteIconButton(
                    onTap: () => _selectMood(mood),
                    moodCategory: mood,
                    isSelected: _selectedMood == mood,
                  );
                },
              ),
            ),
          ),
          if (_moodErrorMessage != null)
            Text(
              _moodErrorMessage!,
              style: const TextStyle(
                color: Colors.red,
              ),
            ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: _controller,
                autocorrect: false,
                maxLines: null,
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: InputDecoration(
                  hintText: "How was your day?".tr(),
                ),
              ),
            ),
          ),
          if (_textErrorMessage != null)
            Text(
              _textErrorMessage!,
              style: const TextStyle(
                color: Colors.red,
              ),
            ),
          GestureDetector(
            onTap: _postMood,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Save".tr()),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _selectMood(MoodCategory mood) {
    _selectedMood = mood;
    setState(() {});
  }

  void _postMood() {
    if (_selectedMood == null) {
      _moodErrorMessage = "Please select your feeling.";
      setState(() {});
      return;
    }
    if (_controller.text.isEmpty) {
      _textErrorMessage = "Please write your feeling.";
      setState(() {});
      return;
    }

    try {
      _viewModel.post(_selectedMood!, _controller.text);
      _resetWriteScreen();
      context.go(RoutePath.home);
    } catch (e) {
      showErrorDialog(
        context: context,
        text: e.toString(),
      );
    }
  }

  void _resetWriteScreen() {
    _controller.text = "";
    _selectedMood = null;
    _moodErrorMessage = null;
    _textErrorMessage = null;
    setState(() {});
  }
}
