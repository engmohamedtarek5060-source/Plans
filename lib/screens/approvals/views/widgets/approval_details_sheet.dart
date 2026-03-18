import 'package:flutter/material.dart';

class ApprovalDetailsSheet extends StatelessWidget {
  final Map<String, dynamic> item;
  final bool isEnglish;

  const ApprovalDetailsSheet({
    super.key,
    required this.item,
    required this.isEnglish,
  });

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

  void _handleApprove(BuildContext context, String requestId) {
    print('Approving request: $requestId');
    Navigator.pop(context);
  }

  void _handleReject(BuildContext context, String requestId) {
    print('Rejecting request: $requestId');
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final statusConfig = _getStatusConfig();
    final isPending = item['status'] == 'pending';

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isEnglish ? 'Request Details' : 'تفاصيل الطلب',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, size: 24),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Divider(color: Colors.grey[300], height: 1),
            const SizedBox(height: 20),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: statusConfig['bgColor'],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: statusConfig['textColor'], width: 1),
                  ),
                  child: Text(
                    statusConfig['text'],
                    style: TextStyle(
                      fontSize: 14,
                      color: statusConfig['textColor'],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.yellow[100],
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.yellow[200]!),
                  ),
                  child: Center(
                    child: Icon(Icons.person, color: Colors.orange, size: 20),
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      item['employee'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      item['employeeCode'],
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Divider(color: Colors.grey[300], height: 1),
            const SizedBox(height: 20),
            Text(
              item['type'],
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              item['subType'],
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isEnglish ? 'From' : 'من',
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                    Text(
                      item['fromDate'],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 40),
                Icon(Icons.arrow_forward, color: Colors.orange, size: 20),
                const SizedBox(width: 40),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isEnglish ? 'To' : 'إلى',
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                    Text(
                      item['toDate'],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isEnglish ? 'Request Date' : 'تاريخ الطلب',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                Text(
                  item['requestDate'],
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Text(
                  isEnglish ? 'Duration' : 'المدة',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                const Spacer(),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: item['duration'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: ' ${item['durationUnit']}',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (item['attachments'] > 0)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black, width: 1),
                ),
                child: Row(
                  children: [
                    Icon(Icons.description, color: Colors.orange, size: 24),
                    const SizedBox(width: 12),
                    Text(
                      isEnglish
                          ? 'View Attached Files (${item['attachments']})'
                          : 'عرض الملفات المرفقة (${item['attachments']})',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              )
            else if (isPending)
              Column(
                children: [
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => _handleReject(context, item['id']),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            isEnglish ? 'Reject' : 'رفض',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => _handleApprove(context, item['id']),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            isEnglish ? 'Approve' : 'موافقة',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}