import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moodtracker/core/theme/mood_color.dart';
import 'package:moodtracker/core/widgets/small_icon_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              child: Card(
                color: MoodColor.white,
                elevation: 0,
                margin: EdgeInsets.zero,
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
                          const FaIcon(FontAwesomeIcons.faceLaugh),
                          Text(
                            "Date",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const Spacer(),
                          SmallIconButton(
                            onTap: () {},
                            icon: FontAwesomeIcons.trashCan,
                          ),
                        ],
                      ),
                      const Text(
                          "asdlkfjoiewhjkl;jas jd fopqwaiuhefpoiuhas dfhow dfas dfasd fas df  fasdfasd fasd f f fdsa fsa df asdf asd f asdfasd f a sdf as df asdfas dfas d asd f f dfasdfefjo sadojkfo i pasodifj lka;sdfj w3qpoeij laskdjfoiuwaefpoi asdf")
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
