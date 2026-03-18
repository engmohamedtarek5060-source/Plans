import 'package:flutter/material.dart';
import 'approval_details_sheet.dart';

class ApprovalsList extends StatelessWidget {
  final bool isEnglish;
  final String status;

  const ApprovalsList({
    super.key,
    required this.isEnglish,
    required this.status,
  });

  List<Map<String, dynamic>> _getItems() {
    if (status == 'All') {
      return [
        {
          'id': 'REQ-001',
          'employee': isEnglish ? 'Ahmed Mohamed' : 'أحمد محمد',
          'employeeCode': 'EMP-001',
          'type': isEnglish ? 'Sick Leave' : 'إجازة مرضية',
          'subType': isEnglish
              ? 'Sick Leave - Medical Report Attached'
              : 'إجازة مرضية - تقرير طبي مرفق',
          'date': isEnglish ? 'Yesterday' : 'أمس',
          'duration': '3',
          'durationUnit': isEnglish ? 'Days' : 'أيام',
          'status': 'pending',
          'attachments': 1,
          'requestDate': isEnglish ? '15 Feb 2024' : '١٥ فبراير ٢٠٢٤',
          'fromDate': isEnglish ? '18 Feb 2024' : '١٨ فبراير ٢٠٢٤',
          'toDate': isEnglish ? '20 Feb 2024' : '٢٠ فبراير ٢٠٢٤',
        },
        {
          'id': 'REQ-002',
          'employee': isEnglish ? 'Sara Ali' : 'سارة علي',
          'employeeCode': 'EMP-002',
          'type': isEnglish ? 'Advance Payment' : 'سلفة',
          'subType': isEnglish
              ? 'Advance for Personal Needs'
              : 'سلفة لاحتياجات شخصية',
          'date': isEnglish ? '2 days ago' : 'قبل يومين',
          'duration': '1500',
          'durationUnit': 'ر.س',
          'status': 'pending',
          'attachments': 0,
          'requestDate': isEnglish ? '14 Feb 2024' : '١٤ فبراير ٢٠٢٤',
          'fromDate': isEnglish ? '14 Feb 2024' : '١٤ فبراير ٢٠٢٤',
          'toDate': isEnglish ? '14 Feb 2024' : '١٤ فبراير ٢٠٢٤',
        },
        {
          'id': 'REQ-003',
          'employee': isEnglish ? 'Mohamed Hassan' : 'محمد حسن',
          'employeeCode': 'EMP-003',
          'type': isEnglish ? 'Annual Leave' : 'إجازة سنوية',
          'subType': isEnglish ? 'Annual Vacation' : 'إجازة سنوية',
          'date': isEnglish ? '1 week ago' : 'قبل أسبوع',
          'duration': '5',
          'durationUnit': isEnglish ? 'Days' : 'أيام',
          'status': 'approved',
          'attachments': 2,
          'requestDate': isEnglish ? '10 Feb 2024' : '١٠ فبراير ٢٠٢٤',
          'fromDate': isEnglish ? '12 Feb 2024' : '١٢ فبراير ٢٠٢٤',
          'toDate': isEnglish ? '16 Feb 2024' : '١٦ فبراير ٢٠٢٤',
        },
        {
          'id': 'REQ-004',
          'employee': isEnglish ? 'Fatima Khalid' : 'فاطمة خالد',
          'employeeCode': 'EMP-004',
          'type': isEnglish ? 'Emergency Leave' : 'إجازة طارئة',
          'subType': isEnglish ? 'Family Emergency' : 'حالة طارئة عائلية',
          'date': isEnglish ? '2 weeks ago' : 'قبل أسبوعين',
          'duration': '2',
          'durationUnit': isEnglish ? 'Days' : 'أيام',
          'status': 'rejected',
          'attachments': 1,
          'requestDate': isEnglish ? '5 Feb 2024' : '٥ فبراير ٢٠٢٤',
          'fromDate': isEnglish ? '6 Feb 2024' : '٦ فبراير ٢٠٢٤',
          'toDate': isEnglish ? '7 Feb 2024' : '٧ فبراير ٢٠٢٤',
        },
      ];
    } else if (status == 'Pending') {
      return [
        {
          'id': 'REQ-001',
          'employee': isEnglish ? 'Ahmed Mohamed' : 'أحمد محمد',
          'employeeCode': 'EMP-001',
          'type': isEnglish ? 'Sick Leave' : 'إجازة مرضية',
          'subType': isEnglish
              ? 'Sick Leave - Medical Report Attached'
              : 'إجازة مرضية - تقرير طبي مرفق',
          'date': isEnglish ? 'Yesterday' : 'أمس',
          'duration': '3',
          'durationUnit': isEnglish ? 'Days' : 'أيام',
          'status': 'pending',
          'attachments': 1,
          'requestDate': isEnglish ? '15 Feb 2024' : '١٥ فبراير ٢٠٢٤',
          'fromDate': isEnglish ? '18 Feb 2024' : '١٨ فبراير ٢٠٢٤',
          'toDate': isEnglish ? '20 Feb 2024' : '٢٠ فبراير ٢٠٢٤',
        },
        {
          'id': 'REQ-002',
          'employee': isEnglish ? 'Sara Ali' : 'سارة علي',
          'employeeCode': 'EMP-002',
          'type': isEnglish ? 'Advance Payment' : 'سلفة',
          'subType': isEnglish
              ? 'Advance for Personal Needs'
              : 'سلفة لاحتياجات شخصية',
          'date': isEnglish ? '2 days ago' : 'قبل يومين',
          'duration': '1500',
          'durationUnit': 'ر.س',
          'status': 'pending',
          'attachments': 0,
          'requestDate': isEnglish ? '14 Feb 2024' : '١٤ فبراير ٢٠٢٤',
          'fromDate': isEnglish ? '14 Feb 2024' : '١٤ فبراير ٢٠٢٤',
          'toDate': isEnglish ? '14 Feb 2024' : '١٤ فبراير ٢٠٢٤',
        },
      ];
    } else if (status == 'Approved') {
      return [
        {
          'id': 'REQ-003',
          'employee': isEnglish ? 'Mohamed Hassan' : 'محمد حسن',
          'employeeCode': 'EMP-003',
          'type': isEnglish ? 'Annual Leave' : 'إجازة سنوية',
          'subType': isEnglish ? 'Annual Vacation' : 'إجازة سنوية',
          'date': isEnglish ? '1 week ago' : 'قبل أسبوع',
          'duration': '5',
          'durationUnit': isEnglish ? 'Days' : 'أيام',
          'status': 'approved',
          'attachments': 2,
          'requestDate': isEnglish ? '10 Feb 2024' : '١٠ فبراير ٢٠٢٤',
          'fromDate': isEnglish ? '12 Feb 2024' : '١٢ فبراير ٢٠٢٤',
          'toDate': isEnglish ? '16 Feb 2024' : '١٦ فبراير ٢٠٢٤',
        },
        {
          'id': 'REQ-005',
          'employee': isEnglish ? 'Yousef Ahmed' : 'يوسف أحمد',
          'employeeCode': 'EMP-005',
          'type': isEnglish ? 'Work From Home' : 'عمل من المنزل',
          'subType': isEnglish ? 'WFH - Friday' : 'عمل من المنزل - الجمعة',
          'date': isEnglish ? '3 days ago' : 'قبل ثلاثة أيام',
          'duration': '1',
          'durationUnit': isEnglish ? 'Day' : 'يوم',
          'status': 'approved',
          'attachments': 0,
          'requestDate': isEnglish ? '13 Feb 2024' : '١٣ فبراير ٢٠٢٤',
          'fromDate': isEnglish ? '16 Feb 2024' : '١٦ فبراير ٢٠٢٤',
          'toDate': isEnglish ? '16 Feb 2024' : '١٦ فبراير ٢٠٢٤',
        },
      ];
    } else if (status == 'Rejected') {
      return [
        {
          'id': 'REQ-004',
          'employee': isEnglish ? 'Fatima Khalid' : 'فاطمة خالد',
          'employeeCode': 'EMP-004',
          'type': isEnglish ? 'Emergency Leave' : 'إجازة طارئة',
          'subType': isEnglish ? 'Family Emergency' : 'حالة طارئة عائلية',
          'date': isEnglish ? '2 weeks ago' : 'قبل أسبوعين',
          'duration': '2',
          'durationUnit': isEnglish ? 'Days' : 'أيام',
          'status': 'rejected',
          'attachments': 1,
          'requestDate': isEnglish ? '5 Feb 2024' : '٥ فبراير ٢٠٢٤',
          'fromDate': isEnglish ? '6 Feb 2024' : '٦ فبراير ٢٠٢٤',
          'toDate': isEnglish ? '7 Feb 2024' : '٧ فبراير ٢٠٢٤',
        },
        {
          'id': 'REQ-006',
          'employee': isEnglish ? 'Khaled Omar' : 'خالد عمر',
          'employeeCode': 'EMP-006',
          'type': isEnglish ? 'Overtime Request' : 'طلب عمل إضافي',
          'subType': isEnglish ? 'Weekend Overtime' : 'عمل إضافي نهاية الأسبوع',
          'date': isEnglish ? '1 month ago' : 'قبل شهر',
          'duration': '8',
          'durationUnit': isEnglish ? 'Hours' : 'ساعات',
          'status': 'rejected',
          'attachments': 0,
          'requestDate': isEnglish ? '20 Jan 2024' : '٢٠ يناير ٢٠٢٤',
          'fromDate': isEnglish ? '27 Jan 2024' : '٢٧ يناير ٢٠٢٤',
          'toDate': isEnglish ? '27 Jan 2024' : '٢٧ يناير ٢٠٢٤',
        },
      ];
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    final items = _getItems();

    if (items.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.inbox_outlined, size: 60, color: Colors.grey[300]),
              const SizedBox(height: 16),
              Text(
                isEnglish ? 'No requests found' : 'لا توجد طلبات',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                isEnglish
                    ? 'There are no $status requests at the moment'
                    : 'لا توجد طلبات $status في الوقت الحالي',
                style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return _RequestItem(item: item, isEnglish: isEnglish);
      },
    );
  }
}

class _RequestItem extends StatelessWidget {
  final Map<String, dynamic> item;
  final bool isEnglish;

  const _RequestItem({required this.item, required this.isEnglish});

  Map<String, dynamic> _getStatusConfig() {
    switch (item['status']) {
      case 'pending':
        return {
          'color': Colors.orange,
          'text': isEnglish ? 'Pending' : 'معلقة',
          'bgColor': Colors.yellow[100],
          'textColor': Colors.orange,
        };
      case 'approved':
        return {
          'color': Colors.green,
          'text': isEnglish ? 'Approved' : 'موافق عليها',
          'bgColor': Colors.green[100],
          'textColor': Colors.green,
        };
      case 'rejected':
        return {
          'color': Colors.red,
          'text': isEnglish ? 'Rejected' : 'مرفوضة',
          'bgColor': Colors.red[100],
          'textColor': Colors.red,
        };
      default:
        return {
          'color': Colors.grey,
          'text': isEnglish ? 'Unknown' : 'غير معروف',
          'bgColor': Colors.grey[100],
          'textColor': Colors.grey,
        };
    }
  }

  void _showApprovalDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) =>
          ApprovalDetailsSheet(item: item, isEnglish: isEnglish),
    );
  }

  @override
  Widget build(BuildContext context) {
    final statusConfig = _getStatusConfig();

    return GestureDetector(
      onTap: () => _showApprovalDetails(context),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            if (item['status'] == 'pending')
              Positioned(
                top: -5,
                left: 15,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Container(
                      width: 4,
                      height: 4,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ),
            Positioned(
              top: 12,
              left: 12,
              child: Icon(Icons.arrow_back, color: Colors.grey[500], size: 18),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: statusConfig['bgColor'],
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: statusConfig['textColor'],
                            width: 1,
                          ),
                        ),
                        child: Text(
                          statusConfig['text'],
                          style: TextStyle(
                            fontSize: 12,
                            color: statusConfig['textColor'],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        item['employee'],
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Colors.yellow[100],
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.yellow[200]!),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.airplanemode_active,
                            color: Colors.orange,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    item['type'],
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.end,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item['subType'],
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    textAlign: TextAlign.end,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (item['attachments'] > 0)
                        Row(
                          children: [
                            Icon(
                              Icons.description,
                              color: Colors.grey[500],
                              size: 14,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              '${item['attachments']}',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(width: 12),
                          ],
                        ),
                      Text(
                        item['date'],
                        style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                      ),
                      const SizedBox(width: 2),
                      Icon(
                        Icons.access_time,
                        color: Colors.grey[500],
                        size: 14,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: item['duration'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: ' ${item['durationUnit']}',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
