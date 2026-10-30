import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/course.dart';
import '../providers/course_provider.dart';

class CourseAddPage extends StatefulWidget {
  const CourseAddPage({super.key});

  @override
  State<CourseAddPage> createState() => _CourseAddPageState();
}

class _CourseAddPageState extends State<CourseAddPage> {
  final _formKey = GlobalKey<FormState>();
  
  final _codeController = TextEditingController();
  final _titleController = TextEditingController();
  final _creditsController = TextEditingController();
  String _status = 'planned'; // Default value

  Future<void> _submitForm() async {
    // Validasi form (Poin 2)
    if (!_formKey.currentState!.validate()) return;

    final provider = context.read<CourseProvider>();
    
    final newCourse = Course(
      code: _codeController.text,
      title: _titleController.text,
      credits: int.parse(_creditsController.text),
      status: _status,
    );

    // Kirim data dan tunggu hasilnya (Poin 3)
    final success = await provider.addCourse(newCourse);

    // Poin 6: Cek context.mounted sebelum pakai context untuk SnackBar/Navigator
    if (!mounted) return; 

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Berhasil menambah mata kuliah!'), 
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context); // Kembali ke list sebelumnya
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(provider.error ?? 'Gagal menambah data'), 
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Poin 4: Ambil status loading (isSaving) dari Provider
    final isSaving = context.watch<CourseProvider>().isSaving;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Mata Kuliah'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _codeController,
                enabled: !isSaving,
                decoration: const InputDecoration(labelText: 'Kode Mata Kuliah (cth: MOB01)'),
                validator: (value) => value == null || value.isEmpty ? 'Kode wajib diisi' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _titleController,
                enabled: !isSaving,
                decoration: const InputDecoration(labelText: 'Nama Mata Kuliah'),
                validator: (value) => value == null || value.isEmpty ? 'Nama wajib diisi' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _creditsController,
                enabled: !isSaving,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'SKS (Credits)'),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'SKS wajib diisi';
                  if (int.tryParse(value) == null) return 'SKS harus berupa angka';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _status, // Ubah 'value' menjadi 'initialValue'
                decoration: const InputDecoration(labelText: 'Status'),
                items: const [
                  DropdownMenuItem(value: 'planned', child: Text('Planned')),
                  DropdownMenuItem(value: 'active', child: Text('Active')),
                  DropdownMenuItem(value: 'done', child: Text('Done')),
                ],
                onChanged: isSaving ? null : (val) => setState(() => _status = val!), // Tambahkan garis bawah pada _status
              ),
              const SizedBox(height: 32),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  // Nonaktifkan tombol saat isSaving true
                  onPressed: isSaving ? null : _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                  ),
                  child: isSaving 
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Simpan Data', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}