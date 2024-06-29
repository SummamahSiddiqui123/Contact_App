import 'package:flutter/material.dart';

void main() {
  runApp(ContactApp());
}

class ContactApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ContactPage(),
    );
  }
}

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  List<Contact> contacts = [
    Contact(name: "John", surname: "Doe", phoneNumber: "1234567890"),
    Contact(name: "Jane", surname: "Smith", phoneNumber: "9876543210"),
    Contact(name: "Jessica", surname: "Parker", phoneNumber: "9876543210"),
    Contact(name: "Roberto", surname: "Ellis", phoneNumber: "9876543210"),
    Contact(name: "Steven", surname: "Gray", phoneNumber: "9876543210"),
    Contact(name: "Kaye", surname: "James", phoneNumber: "9876543210"),
    Contact(name: "Steven", surname: "Lecompte", phoneNumber: "9876543210"),
    Contact(name: "Doris", surname: "Sutton", phoneNumber: "9876543210"),
    Contact(name: "Taylor", surname: "Davis", phoneNumber: "9876543210"),
    Contact(name: "Williams", surname: "Evans", phoneNumber: "9876543210"),
    Contact(name: "Smith", surname: "johnson", phoneNumber: "9876543210"),
    Contact(name: "Jones", surname: "Alice", phoneNumber: "9876543210"),
  ];

  List<String> recentCalls = [
    "John Doe - 1234567890",
    "Jane Smith - 9876543210",
    "Alice Johnson - 5551234567",
    "Taylor Davis - 9876543210",
    "Steven Gray - 5551234567",
    "Roberto Ellis - 9876543210",
    "Kaye James - 5551234567",
    "Williams Evans - 9876543210",
    "Jessica Parker - 5551234567",
  ];

  String newName = '';
  String newSurname = '';
  String newPhoneNumber = '';

  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  void addContact(String name, String surname, String phoneNumber) {
    setState(() {
      contacts.add(Contact(
        name: name,
        surname: surname,
        phoneNumber: phoneNumber,
      ));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Contact added')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contacts')),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddContactPage(addContact)),
          );
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            label: 'Recent',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts),
            label: 'Contacts',
          ),
        ],
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RecentPage(recentCalls)),
            );
          }
        },
      ),
    );
  }

  Widget _buildBody() {
    return ListView.builder(
      itemCount: contacts.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('${contacts[index].name} ${contacts[index].surname}'),
          subtitle: Text('${contacts[index].phoneNumber}'),
          trailing: Icon(Icons.phone, color: Colors.green),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ContactDetailPage(contact: contacts[index]),
              ),
            );
          },
        );
      },
    );
  }
}

class Contact {
  final String name;
  final String surname;
  final String phoneNumber;

  Contact({
    required this.name,
    required this.surname,
    required this.phoneNumber,
  });
}

class AddContactPage extends StatelessWidget {
  final Function(String, String, String) addContact;

  AddContactPage(this.addContact);

  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Contact')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: nameController,
              onChanged: (value) {},
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: surnameController,
              onChanged: (value) {},
              decoration: InputDecoration(labelText: 'Surname'),
            ),
            TextField(
              controller: phoneNumberController,
              onChanged: (value) {},
              decoration: InputDecoration(labelText: 'Phone number'),
            ),
            ElevatedButton(
              onPressed: () {
                addContact(
                  nameController.text,
                  surnameController.text,
                  phoneNumberController.text,
                );
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}

class ContactDetailPage extends StatelessWidget {
  final Contact contact;

  ContactDetailPage({required this.contact});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Detail'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              child: Icon(Icons.person, size: 50),
            ),
            SizedBox(height: 20),
            Text(
              '${contact.name} ${contact.surname}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '${contact.phoneNumber}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Recent Call Logs:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            _buildCallLogs(),
          ],
        ),
      ),
    );
  }

  Widget _buildCallLogs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.call_received, color: Colors.green),
          title: Text('Incoming Call - 10:00 AM'),
          subtitle: Text('Duration: 5 minutes'),
        ),
        ListTile(
          leading: Icon(Icons.call_made, color: Colors.blue),
          title: Text('Outgoing Call - 11:30 AM'),
          subtitle: Text('Duration: 8 minutes'),
        ),
        ListTile(
          leading: Icon(Icons.call_received, color: Colors.green),
          title: Text('Missed Call - 2:15 PM'),
        ),
      ],
    );
  }
}

class RecentPage extends StatelessWidget {
  final List<String> recentCalls;

  RecentPage(this.recentCalls);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recent Calls'),
      ),
      body: ListView.builder(
        itemCount: recentCalls.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(recentCalls[index]),
            trailing: Icon(Icons.phone),
            onTap: () {
              // Handle tap on recent call item
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text('Tapped recent call: ${recentCalls[index]}')),
              );
            },
          );
        },
      ),
    );
  }
}
