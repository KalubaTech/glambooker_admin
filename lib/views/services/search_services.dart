import 'package:flutter/material.dart';
import 'package:glambooker_admin/customs/kalutext.dart';
import 'package:glambooker_admin/utils/colors.dart';

class SearchServices extends StatelessWidget {
  SearchServices({super.key});

  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Karas.background,
      appBar: AppBar(
        title: Text('Search'),
        backgroundColor: Karas.background,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Kalutext(
                controller: _searchController,
                hintText: 'Search service...',
            )
          ],
        ),
      ),
    );
  }
}
