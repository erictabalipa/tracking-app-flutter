import 'package:app_pinho_express/utils/app_routes.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key, required this.title});
  final String title;

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List _items = [
    "Notify 1", 
    "Notify 2", 
    "Notify 3",
    "Notify 4",
    "Notify 5",
    "Notify 6",
    "Notify 7",
    "Notify 8",
    "Notify 9",
    "Notify 10"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.notifications_active_outlined),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.NOTIFICATION_ROUTE);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Expanded(
            child: ListView.separated(
              itemCount: _items.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/process/detail', arguments: {
                      'title': 'Processo${_items[index]}',
                      'description': 'Processo${_items[index]}',
                    });
                  },
                  child: Dismissible(
                    key: Key(index.toString()),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      setState(() {
                        _items = _items.removeAt(index); 
                      });
                    },
                    background: Container(
                      color: Colors.red,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const [
                              Text('DESCARTAR',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(width: 10),
                              Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    child: ListTile(
                      title: Text(_items[index]),
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            )),
      ),
      // bottomNavigationBar: const AppBottomNavigationBar(
      //   selectedIndex: 0,
      // ),
    );
  }
}
