import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:moodtracker/core/models/mood/mood_type.dart';
import 'package:moodtracker/core/widgets/small_icon_button.dart';

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
            return Column(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Column(
                      spacing: 8,
                      children: [
                        Row(
                          spacing: 10,
                          children: [
                            Icon(
                              MoodType.smile.toIcon(),
                              size: 30,
                            ),
                            Text(
                              "Date",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const Spacer(),
                            SmallIconButton(
                              onTap: () {},
                              icon: FontAwesomeIcons.trashCan,
                            ),
                          ],
                        ),
                        const Text(
                            "asdlkfjoiewhjkl;jas jd fopqwaiuhefpoiuhas dfhow dfas dfasd fas df  fasdfasd fasd f f fdsa fsa df asdf asd f asdfasd f a sdf as df asdfas dfas d asd f f dfasdfefjo sadojkfo i pasodifj lka;sdfj w3qpoeij laskdjfoiuwaefpoi asdf"),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
