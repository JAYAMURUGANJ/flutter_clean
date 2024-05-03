import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/config/common/extensions.dart';
import 'package:news_app_clean_architecture/features/temple_details/domain/entities/contact_details.dart';
import 'package:news_app_clean_architecture/features/temple_details/presentation/widgets/bottom_sheet.dart';
import 'package:news_app_clean_architecture/features/temple_list/domain/entities/itms_response.dart';

import '../bloc/contact_details/contact_details_bloc.dart';

import 'main_tower.dart';

class BuildContactDetails extends StatefulWidget {
  final ItmsResponseEntity temple;
  const BuildContactDetails(this.temple, {Key? key}) : super(key: key);

  @override
  State<BuildContactDetails> createState() => _BuildContactDetailsState();
}

class _BuildContactDetailsState extends State<BuildContactDetails> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ContactDetailsBloc>(context)
        .add(GetContactDetails(templeId: widget.temple.templeId.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.white,
                  Theme.of(context).colorScheme.primary.blend(Colors.white),
                  Theme.of(context).colorScheme.primary,
                ],
              ),
            ),
            height: MediaQuery.sizeOf(context).height / 3,
          ),
          BlocBuilder<ContactDetailsBloc, ContactDetailsState>(
            builder: (context, state) {
              if (state is ContactDetailsLoaded) {
                ContactDetailsEntity contactDetails = state.contactDetails![0];
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
                        child: Text(
                          contactDetails.templeName ?? "",
                          softWrap: true,
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                        ),
                      ),
                      5.ph,
                      mainTower(widget.temple, 80),
                      buildContactCard(
                          context,
                          "designation",
                          contactDetails.designationDesc ?? "-",
                          Icons.contact_emergency,
                          () {}),
                      buildContactCard(
                          context,
                          "address",
                          "${contactDetails.templeDoorno!}, ${contactDetails.templeStreet!}, ${contactDetails.templeLocation}, ${contactDetails.districtName} - ${contactDetails.pincode}",
                          Icons.location_on_outlined,
                          () {}),
                      buildContactCard(
                          context,
                          "email",
                          contactDetails.email ?? "",
                          Icons.mail_outline,
                          () {}),
                      buildContactCard(
                          context,
                          "phone",
                          contactDetails.landline!,
                          Icons.phone_outlined,
                          () {}),
                      buildContactCard(
                          context, "website", "-", Icons.language, () {}),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          )
        ],
      ),
    );
  }
}
