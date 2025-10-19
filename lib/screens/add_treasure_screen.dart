import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../services/treasure_provider.dart';
import '../models/treasure_entry.dart';
import '../constants/app_colors.dart';
import '../constants/app_constants.dart';
import '../l10n/app_localizations.dart';

class AddTreasureScreen extends StatefulWidget {
  final TreasureEntry? existingEntry;

  const AddTreasureScreen({super.key, this.existingEntry});

  @override
  State<AddTreasureScreen> createState() => _AddTreasureScreenState();
}

class _AddTreasureScreenState extends State<AddTreasureScreen> {
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();
  final _valueController = TextEditingController();
  
  List<TreasureType> _selectedTypes = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.existingEntry != null) {
      _textController.text = widget.existingEntry!.text;
      _valueController.text = widget.existingEntry!.value.toString();
      _selectedTypes = List.from(widget.existingEntry!.types);
    } else {
      _valueController.text = '1';
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    _valueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isEditing = widget.existingEntry != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Treasure' : l10n.addNewTreasure),
        actions: [
          if (isEditing)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: _showDeleteDialog,
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Description field
              Text(
                l10n.treasureDescription,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _textController,
                maxLines: 4,
                maxLength: AppConstants.maxTreasureTextLength,
                decoration: InputDecoration(
                  hintText: 'Describe your treasure...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please describe your treasure';
                  }
                  if (value.length > AppConstants.maxTreasureTextLength) {
                    return 'Description is too long';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 24),

              // Treasure types
              Text(
                l10n.selectTreasureTypes,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: TreasureType.values.map((type) {
                  final isSelected = _selectedTypes.contains(type);
                  return FilterChip(
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(type.emoji),
                        const SizedBox(width: 4),
                        Text(type.displayName),
                      ],
                    ),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          if (_selectedTypes.length < AppConstants.maxTagsPerEntry) {
                            _selectedTypes.add(type);
                          }
                        } else {
                          _selectedTypes.remove(type);
                        }
                      });
                    },
                    selectedColor: AppColors.treasureColors[type.name]?.withOpacity(0.2),
                    checkmarkColor: AppColors.treasureColors[type.name],
                    side: BorderSide(
                      color: AppColors.treasureColors[type.name] ?? AppColors.primary,
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 24),

              // Treasure value
              Text(
                l10n.treasureValue,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _valueController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter treasure value (1-100)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  suffixIcon: const Icon(Icons.star),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a value';
                  }
                  final intValue = int.tryParse(value);
                  if (intValue == null || intValue < 1 || intValue > 100) {
                    return 'Value must be between 1 and 100';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 32),

              // Save button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _saveTreasure,
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(isEditing ? 'Update Treasure' : l10n.saveTreasure),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveTreasure() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedTypes.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least one treasure type'),
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final provider = Provider.of<TreasureProvider>(context, listen: false);
      final value = int.parse(_valueController.text);
      
      if (widget.existingEntry != null) {
        // Update existing entry
        final updatedEntry = widget.existingEntry!.copyWith(
          text: _textController.text.trim(),
          types: _selectedTypes,
          value: value,
          updatedAt: DateTime.now(),
        );
        await provider.updateTreasureEntry(updatedEntry);
      } else {
        // Create new entry
        final newEntry = TreasureEntry(
          id: const Uuid().v4(),
          text: _textController.text.trim(),
          types: _selectedTypes,
          value: value,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        await provider.addTreasureEntry(newEntry);
      }

      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              widget.existingEntry != null 
                  ? 'Treasure updated successfully!' 
                  : 'Treasure added successfully!',
            ),
            backgroundColor: AppColors.success,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving treasure: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _showDeleteDialog() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Treasure'),
        content: const Text('Are you sure you want to delete this treasure?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      try {
        final provider = Provider.of<TreasureProvider>(context, listen: false);
        await provider.deleteTreasureEntry(widget.existingEntry!.id);
        
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Treasure deleted successfully!'),
            backgroundColor: AppColors.success,
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error deleting treasure: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }
}

