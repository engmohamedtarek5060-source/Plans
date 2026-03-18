import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isEnglish;
  final String selectedBranch;
  final int notificationCount;
  final VoidCallback onBranchTap;
  final VoidCallback onNotificationsTap; // إضافة هذه الخاصية

  const HomeAppBar({
    super.key,
    required this.isEnglish,
    required this.selectedBranch,
    required this.notificationCount,
    required this.onBranchTap,
    required this.onNotificationsTap, // إضافة هذه الخاصية
  });

  final List<Map<String, dynamic>> branches = const [
    {'name': 'الفرع الرئيسي', 'englishName': 'Main Branch'},
    {'name': 'فرع جدة', 'englishName': 'Jeddah Branch'},
    {'name': 'فرع الدمام', 'englishName': 'Dammam Branch'},
  ];

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  String get _branchDisplayName {
    final branch = branches.firstWhere(
      (b) => b['name'] == selectedBranch,
      orElse: () => branches[0],
    );
    return isEnglish ? branch['englishName'] : branch['name'];
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: _buildLogoImage(),
      ),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFE65100), Color(0xFFFF9800)],
          ),
        ),
      ),
      title: GestureDetector(
        onTap: onBranchTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isEnglish ? 'Plans Company' : 'شركة النحبه للتحاره',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              maxLines: 1,
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                // أيقونة الموقع على الشمال
                Icon(
                  Icons.location_on,
                  color: Colors.white.withOpacity(0.8),
                  size: 16,
                ),
                const SizedBox(width: 4),

                // نص العنوان والسهم معاً في Flexible
                Flexible(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          _branchDisplayName,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 4),

                      // السهم للأسفل مباشرة بعد النص
                      const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        Stack(
          children: [
            IconButton(
              icon: const Icon(
                Icons.notifications,
                color: Colors.white,
                size: 28,
              ),
              onPressed: onNotificationsTap, // استخدام الخاصية هنا
            ),
            if (notificationCount > 0)
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 20,
                    minHeight: 20,
                  ),
                  child: Text(
                    notificationCount.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(width: 10),
      ],
    );
  }

  Widget _buildLogoImage() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6,
            spreadRadius: 1,
          ),
        ],
      ),
      child: ClipOval(
        child: Image.asset(
          'assets/images/logo.png.jpeg',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFE65100), Color(0xFFFF9800)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.account_circle,
                size: 24,
                color: Colors.white,
              ),
            );
          },
        ),
      ),
    );
  }
}
