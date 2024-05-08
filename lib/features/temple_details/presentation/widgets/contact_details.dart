import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';

import '../bloc/contact_details/contact_details_bloc.dart';
import '/config/common/extensions.dart';
import '/config/constants.dart';
import '/features/temple_details/domain/entities/contact_details.dart';
import '/features/temple_list/domain/entities/itms_response.dart';
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
                      buildTempleName(contactDetails, context),
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

  buildTempleName(ContactDetailsEntity contactDetails, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Text(
        contactDetails.templeName ?? "",
        softWrap: true,
        textAlign: TextAlign.center,
        maxLines: 3,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
      ),
    );
  }
}

buildContactCard(BuildContext context, String lable, String value,
    IconData icon, VoidCallback action,
    {bool localLable = true}) {
  return Padding(
    padding: defaultPadding,
    child: ListTile(
      onTap: action,
      trailing: IconButton(
        icon: Icon(icon),
        highlightColor: Theme.of(context).colorScheme.primary.withOpacity(0.3),
        hoverColor: Colors.white,
        onPressed: action,
      ),
      title: localLable
          ? LocaleText(
              lable,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary),
            )
          : Text(
              "Designation for Temple Inchager",
              softWrap: true,
              maxLines: 2,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
      subtitle: Text(
        value,
        maxLines: 4,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(fontWeight: FontWeight.w500),
      ),
    ),
  );
}
