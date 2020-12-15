import 'package:flutter/material.dart';
import 'package:recruitment_task/blocs/values_bloc.dart';

class UserValuesPage extends StatelessWidget {
  final ValuesBLoC valuesBLoC;
  const UserValuesPage({this.valuesBLoC});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'User Values',
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
        body: StreamBuilder(
            stream: valuesBLoC.userList,
            builder: (BuildContext context, AsyncSnapshot userListSnapshot) {
              return userListSnapshot.data != null &&
                      userListSnapshot.data.length != 0
                  ? ListView.builder(
                      itemCount: userListSnapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.all(16),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text('${userListSnapshot.data[index]}'),
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
