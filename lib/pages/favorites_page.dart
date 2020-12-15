import 'package:flutter/material.dart';
import 'package:recruitment_task/blocs/values_bloc.dart';

class FavoritesPage extends StatelessWidget {
  final ValuesBLoC valuesBLoC;

  const FavoritesPage({
    this.valuesBLoC,
  });
  @override
  Widget build(
    BuildContext context,
  ) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Favorites Values',
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
        body: StreamBuilder(
            stream: valuesBLoC.favoriteList,
            builder:
                (BuildContext context, AsyncSnapshot favoriteListSnapshot) {
              return favoriteListSnapshot.data != null &&
                      favoriteListSnapshot.data.length != 0
                  ? ListView.builder(
                      itemCount: favoriteListSnapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.all(16),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text('${favoriteListSnapshot.data[index]} '),
                          ),
                        );
                      },
                    )
                  : Container();
            }),
      ),
    );
  }
}
