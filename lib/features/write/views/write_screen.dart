import 'package:flutter/material.dart';
import 'package:moodtracker/core/models/mood/mood_type.dart';
import 'package:moodtracker/core/widgets/mood_card.dart';
import 'package:moodtracker/features/write/views/widgets/write_icon_button.dart';

class WriteScreen extends StatelessWidget {
  const WriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        child: Column(
          spacing: 8,
          children: [
            MoodCard(
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
            MoodCard(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  autocorrect: false,
                  maxLines: null,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: const MoodCard(
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
      ),
    );
  }
}
