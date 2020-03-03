import 'package:flutter/material.dart';
import 'package:june_lake/api/entry_service.dart';
import 'package:june_lake/model/entry.dart';
import 'package:provider/provider.dart';

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
