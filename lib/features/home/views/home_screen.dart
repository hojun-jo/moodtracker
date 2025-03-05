import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:moodtracker/core/models/mood/mood_type.dart';
import 'package:moodtracker/features/home/views/widgets/mood_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: firestore에서 데이터 가져오기
    return CustomScrollView(
      slivers: [
        SliverList.separated(
          separatorBuilder: (context, index) => const Gap(20),
          itemCount: 10,
          itemBuilder: (context, index) {
            return MoodCard(
              onTrashTap: () {},
              moodType: MoodType.smile,
              createdAt: "2025.03.05.",
              description:
                  "asdlkfjoihj aowiejf askldjhf pawoeifh oaisd lkajwf oie fa;wokjdsjbnvh wopeihv avlskjdhv apwoeiuv hpaosdvkm as;dvkljh awoevh akjlsdhf p;oawief a;sdklf kjsadhfoiawehofpi",
            );
          },
        ),
      ],
    );
  }
}
