import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'entry.dart';
import 'entry_service.dart';

class EntryProvider extends StatelessWidget {
  final Widget child;
  EntryProvider({this.child});

  @override
  Widget build(BuildContext context) {
    // provide streams to the app to watch
    return MultiProvider(
      providers: [
        StreamProvider<List<Entry>>.value(
          value: entryService.asList(),
          lazy: true,
        ),
      ],
      child: child,
    );
  }
}
