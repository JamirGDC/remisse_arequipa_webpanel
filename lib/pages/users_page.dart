import 'package:flutter/material.dart';
import 'package:remisseaqpweb/widgets/users_data_list.dart';
import '../methods/common_methods.dart';

class UsersPage extends StatefulWidget
{
  static const String id = "\webPageUsers";

  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage>
{
  CommonMethods cMethods = CommonMethods();


  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Container(
                alignment: Alignment.topLeft,
                child: const Text(
                  "Manage Users",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(
                height: 18,
              ),

              Row(
                children: [
                  cMethods.header(2, "ID"),
                  cMethods.header(1, "Nombre"),
                  cMethods.header(1, "Email"),
                  cMethods.header(1, "Teléfono"),
                  cMethods.header(1, "Acciones"),
                ],
              ),

              //display data
              UsersDataList(),
            ],
          ),
        ),
      ),
    );
  }
}
