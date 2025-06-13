import 'package:db_practice/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
      body: Consumer(
        builder: (ctx, _, __) {
          return SwitchListTile.adaptive(
            value: Provider.of<ThemeProvider>(ctx).getThemeValue(),
            onChanged: (value) {
              Provider.of<ThemeProvider>(ctx, listen: false).updateTheme(value);
            },
          );
        },
      ),
    );
  }
}
