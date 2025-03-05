import 'package:flutter/material.dart';
import 'package:moodtracker/core/models/mood/mood_type.dart';
import 'package:moodtracker/features/write/views/widgets/write_icon_button.dart';

class WriteScreen extends StatelessWidget {
  const WriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: 아이콘 선택 색상 구현
    // TODO: post 기능(파이어스토어에 저장) 구현
    return SingleChildScrollView(
      child: Column(
        spacing: 8,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ...MoodType.values.map((mood) {
                    return WriteIconButton(
                      onTap: () {},
                      icon: mood.toIcon(),
                    );
                  }),
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                autocorrect: false,
                maxLines: null,
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: const InputDecoration(
                  hintText: "How was your day?",
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: const Card(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Post"),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
