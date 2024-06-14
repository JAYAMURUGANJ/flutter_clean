import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:news_app_clean_architecture/config/common/extensions.dart';
import 'package:news_app_clean_architecture/features/temple_details/presentation/widgets/temple_info.dart';

import '/config/constants.dart';

LocaleText buildHeading(BuildContext context, String text, {TextStyle? style}) {
  return LocaleText(
    text,
    textAlign: TextAlign.left,
    style: style ??
        Theme.of(context)
            .textTheme
            .labelSmall!
            .copyWith(fontWeight: FontWeight.bold),
  );
}

Widget buildlabelValueTxt(BuildContext context, String title, String? value) {
  return value != null
      ? Padding(
          padding: defaultPadding.add(const EdgeInsets.only(bottom: 8)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              LocaleText(
                title,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary),
              ),
              3.ph,
              Text(value,
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        )
      : const SizedBox.shrink();
}

Widget buildTabularlabelValueTxt(
    BuildContext context, List<TitleValue> listItem) {
  List<TitleValue> filteredList = listItem
      .where((item) => item.value != null && item.value!.isNotEmpty)
      .toList();

  return Padding(
      padding: defaultPadding.add(const EdgeInsets.only(bottom: 8)),
      child: Table(
          border: TableBorder.all(
              width: 1,
              borderRadius: BorderRadius.circular(8),
              color: Colors.black),
          columnWidths: {
            0: FixedColumnWidth(MediaQuery.of(context).size.width * .26)
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.intrinsicHeight,
          children: List.generate(
              filteredList.length,
              (index) => TableRow(children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color:
                              Theme.of(context).colorScheme.primaryContainer),
                      alignment: Alignment.center,
                      clipBehavior: Clip.hardEdge,
                      child: LocaleText(
                        filteredList[index].title,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(),
                      alignment: Alignment.center,
                      clipBehavior: Clip.hardEdge,
                      child: Text(filteredList[index].value ?? "-",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge),
                    ),
                  ]))));
}
