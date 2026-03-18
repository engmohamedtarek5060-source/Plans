// widgets/attachments_section.dart

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AttachmentsSection extends StatelessWidget {
  final bool isEnglish;
  final List<XFile> selectedFiles;
  final VoidCallback onAttachPressed;
  final Function(int) onFileRemoved;

  const AttachmentsSection({
    super.key,
    required this.isEnglish,
    required this.selectedFiles,
    required this.onAttachPressed,
    required this.onFileRemoved,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          isEnglish ? 'Attachments' : 'المرفقات',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onAttachPressed,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[300]!, width: 1.5),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isEnglish ? 'Attach Files' : 'إرفاق ملفات',
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                    const SizedBox(width: 8),
                    Icon(Icons.attach_file, color: Colors.grey[600], size: 20),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  isEnglish ? '(Invoices, Receipts)' : '(فواتير ، إيصالات)',
                  style: TextStyle(color: Colors.grey[500], fontSize: 12),
                ),
                if (selectedFiles.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 60,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: selectedFiles.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 50,
                          height: 50,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            color: Colors.orange.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Stack(
                            children: [
                              const Center(
                                child: Icon(
                                  Icons.insert_drive_file,
                                  color: Colors.orange,
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () => onFileRemoved(index),
                                  child: Container(
                                    width: 16,
                                    height: 16,
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 10,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          alignment: Alignment.centerRight,
          child: Text(
            isEnglish
                ? 'You can attach invoices and receipts (PDF, JPG, PNG)'
                : 'يمكنك إرفاق الفواتير والإيصالات (PDF, JPG, PNG)',
            style: TextStyle(color: Colors.grey[500], fontSize: 12),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
