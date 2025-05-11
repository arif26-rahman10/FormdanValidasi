import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(title: 'Form Pendaftaran Akun'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  String? role = 'User';

  // Fungsi validasi Username
  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username tidak boleh kosong';
    }
    if (value.length < 4 || value.length > 25) {
      return 'Username minimal 4 dan maksimal 25 karakter';
    }
    if (RegExp(r'[0-9]').hasMatch(value)) {
      return 'Username tidak boleh mengandung angka';
    }
    return null;
  }

  // Fungsi validasi Email
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email tidak boleh kosong';
    }
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value)) {
      return 'Email tidak valid';
    }
    return null;
  }

  // Fungsi validasi Nomor HP
  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nomor HP tidak boleh kosong';
    }
    if (value.length < 10 || value.length > 12) {
      return 'Nomor HP harus antara 10 dan 12 karakter';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Nomor HP harus hanya angka';
    }
    return null;
  }

  // Fungsi validasi Password
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password tidak boleh kosong';
    }
    if (value.length < 4 || value.length > 25) {
      return 'Password minimal 4 dan maksimal 25 karakter';
    }
    return null;
  }

  // Fungsi validasi Confirm Password
  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Konfirmasi Password tidak boleh kosong';
    }
    if (value != passwordController.text) {
      return 'Password dan Konfirmasi Password tidak cocok';
    }
    return null;
  }

  // Fungsi untuk menampilkan data yang dimasukkan
  void showData() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
            'Username: ${usernameController.text}\n'
            'Email: ${emailController.text}\n'
            'Nomor HP: ${phoneController.text}\n'
            'Password: ${passwordController.text}\n'
            'Role: $role',
          ),
        );
      },
    );
  }

  // Fungsi untuk validasi input
  void validateInput() {
    if (formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Semua data sudah tervalidasi')));
      showData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              // Username
              TextFormField(
                controller: usernameController,
                decoration: const InputDecoration(
                  hintText: 'Username',
                  labelText: 'Username',
                  icon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: validateUsername,
              ),
              const SizedBox(height: 10.0),

              // Email
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: 'Email',
                  labelText: 'Email',
                  icon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                validator: validateEmail,
              ),
              const SizedBox(height: 10.0),

              // Nomor HP
              TextFormField(
                controller: phoneController,
                decoration: const InputDecoration(
                  hintText: 'Nomor HP',
                  labelText: 'Nomor HP',
                  icon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: validatePhone,
              ),
              const SizedBox(height: 10.0),

              // Password
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                  hintText: 'Password',
                  labelText: 'Password',
                  icon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: validatePassword,
              ),
              const SizedBox(height: 10.0),

              // Confirm Password
              TextFormField(
                controller: confirmPasswordController,
                decoration: const InputDecoration(
                  hintText: 'Confirm Password',
                  labelText: 'Confirm Password',
                  icon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: validateConfirmPassword,
              ),
              const SizedBox(height: 10.0),

              // Role (User/Admin)
              DropdownButtonFormField<String>(
                value: role,
                decoration: const InputDecoration(
                  labelText: 'Role',
                  icon: Icon(Icons.account_circle),
                  border: OutlineInputBorder(),
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    role = newValue!;
                  });
                },
                items: <String>['User', 'Admin']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20.0),

              // Submit Button
              ElevatedButton(
                child: const Text('Submit'),
                onPressed: validateInput,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
