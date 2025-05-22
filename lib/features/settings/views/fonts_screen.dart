import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:moodtracker/core/theme/app_color.dart';
import 'package:moodtracker/core/theme/app_fonts_type.dart';
import 'package:moodtracker/core/widgets/center_progress_indicator.dart';
import 'package:moodtracker/core/widgets/center_text.dart';
import 'package:moodtracker/features/settings/view_models/fonts_view_model.dart';
import 'package:moodtracker/features/settings/views/widgets/fonts_select_radio.dart';

class FontsScreen extends ConsumerStatefulWidget {
  const FontsScreen({super.key});

  @override
  ConsumerState<FontsScreen> createState() => _FontsScreenState();
}

class _FontsScreenState extends ConsumerState<FontsScreen> {
  @override
  Widget build(BuildContext context) {
    final currentFonts = ref.watch(fontsProvider);
    final viewModel = ref.read(fontsProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 20,
      children: [
        Stack(
          children: [
            CenterText(text: "Select Fonts".tr()),
            GestureDetector(
              onTap: () => context.pop(),
              child: const Icon(
                Icons.chevron_left,
                color: AppColor.black,
                size: 28,
              ),
            ),
          ],
        ),
        Expanded(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 20,
              ),
              child: currentFonts.when(
                data: (data) {
                  return Column(
                    children: [
                      ...AppFontsType.values.map((type) {
                        return FontsSelectRadio(
                          type: type,
                          currentValue: data,
                          onChanged: (value) {
                            viewModel.selectFonts(value);
                          },
                        );
                      }),
                    ],
                  );
                },
                error: (error, stackTrace) =>
                    CenterText(text: error.toString()),
                loading: () => const CenterProgressIndicator(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
