import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:remisseaqpweb/methods/common_methods.dart';


class UsersDataList extends StatefulWidget {
  const UsersDataList({super.key});

  @override
  State<UsersDataList> createState() => _UsersDataListState();
}



class _UsersDataListState extends State<UsersDataList>
{
  final usersRecordsFromDatabase = FirebaseDatabase.instance.ref().child("users");
  CommonMethods cMethods = CommonMethods();

  @override
  Widget build(BuildContext context)
  {
    return StreamBuilder(
      stream: usersRecordsFromDatabase.onValue,
      builder: (BuildContext context, snapshotData)
      {
        if(snapshotData.hasError)
        {
          return const Center(
            child: Text(
              "Ha ocurrido un error. Intente más tarde.",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.pink,
              ),
            ),
          );
        }

        if(snapshotData.connectionState == ConnectionState.waiting)
        {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        Map dataMap = snapshotData.data!.snapshot.value as Map;
        List itemsList = [];
        dataMap.forEach((key, value)
        {
          itemsList.add({"key": key, ...value});
        });

        return ListView.builder(
          shrinkWrap: true,
          itemCount: itemsList.length,
          itemBuilder: ((context, index)
          {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                cMethods.data(
                  2,
                  Text(itemsList[index]["id"].toString()),
                ),

                cMethods.data(
                  1,
                  Text(itemsList[index]["name"].toString()),
                ),

                cMethods.data(
                  1,
                  Text(itemsList[index]["email"].toString()),
                ),

                cMethods.data(
                  1,
                  Text(itemsList[index]["phone"].toString()),
                ),

                cMethods.data(
                  1,
                  itemsList[index]["blockStatus"] == "no" ?
                  ElevatedButton(
                    onPressed: () async
                    {
                      await FirebaseDatabase.instance.ref()
                          .child("users")
                          .child(itemsList[index]["id"])
                          .update(
                          {
                            "blockStatus": "yes",
                          });
                    },
                    child: const Text(
                      "Bloquear",
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                      : ElevatedButton(
                    onPressed: () async
                    {
                      await FirebaseDatabase.instance.ref()
                          .child("users")
                          .child(itemsList[index]["id"])
                          .update(
                          {
                            "blockStatus": "no",
                          });
                    },
                    child: const Text(
                      "Aprobar",
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

              ],
            );
          }),
        );
      },
    );
  }
}
