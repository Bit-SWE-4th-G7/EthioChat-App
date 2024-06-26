import 'package:ethiochat/common/widgets/error.dart';
import 'package:ethiochat/common/widgets/loader.dart';
import 'package:ethiochat/features/select_contacts/controller/select_contact_contoller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectContactsScreen extends ConsumerWidget {
  static const String routeName = '/select-contact';

  const SelectContactsScreen({super.key});

  void selectContact(
      WidgetRef ref, Contact selectedContact, BuildContext context) async {
    ref
        .read(selectContactControllerProvider)
        .selectContact(selectedContact, context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Select Contact',
            style: TextStyle(color: Colors.black),
          ),
          actions: [],
        ),
        body: ref.watch(getContactsProvider).when(
            data: (ContactsList) => ListView.builder(
                itemCount: ContactsList.length,
                itemBuilder: (context, index) {
                  final contact = ContactsList[index];
                  return InkWell(
                    onTap: () => selectContact(ref, contact, context),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: ListTile(
                          title: Text(
                            contact.displayName,
                            style: const TextStyle(
                                fontSize: 18, color: Colors.black),
                          ),
                          leading: contact.photo == null
                              ? null
                              : CircleAvatar(
                                  backgroundImage: MemoryImage(contact.photo!),
                                  radius: 30,
                                )),
                    ),
                  );
                }),
            error: (err, trace) => ErrorScreen(error: err.toString()),
            loading: () => const Loader()));
  }
}
