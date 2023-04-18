import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ImportDialog extends StatefulWidget {
  const ImportDialog({super.key});

  @override
  _ImportDialogState createState() => _ImportDialogState();
}

class _ImportDialogState extends State<ImportDialog> {
  @override
  Widget build(BuildContext context) {
    final isMobile = !kIsWeb && (Platform.isAndroid || Platform.isIOS);
    return AlertDialog(
      title: Row(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: PhosphorIcon(PhosphorIconsLight.arrowSquareIn),
          ),
          Text(AppLocalizations.of(context).import),
        ],
      ),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        ListTile(
            onTap: () => Clipboard.getData('text/plain')
                .then((value) => Navigator.of(context).pop(value?.text)),
            title: Text(AppLocalizations.of(context).clipboard)),
        ListTile(
            onTap: () async {
              final navigator = Navigator.of(context);
              final files = await FilePicker.platform.pickFiles(
                type: isMobile ? FileType.any : FileType.custom,
                allowedExtensions: isMobile ? null : ['bfly', 'json'],
                allowMultiple: false,
              );
              if (files?.files.isEmpty ?? true) return;
              var e = files!.files.first;
              var content = String.fromCharCodes(e.bytes ?? Uint8List(0));
              if (!kIsWeb) content = await File(e.path ?? '').readAsString();
              navigator.pop(content);
            },
            title: Text(AppLocalizations.of(context).file)),
      ]),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(AppLocalizations.of(context).cancel)),
      ],
    );
  }
}
