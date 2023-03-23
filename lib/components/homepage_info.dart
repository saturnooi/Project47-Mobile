import 'package:flutter/material.dart';

class HomeInfo extends StatelessWidget {
  const HomeInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            const Text('We Smile+ Clinic'),
            const Text('เปิดบริการ 10.00 - 20.00 น.'),
            const Text('ตั้งอยู่ที่ 321 ถ.เฉลิมพระเกียรติ'),
            const Text('แขวงหนองบอน เขตประเวศ'),
            const Text('กรุงเทพ 10520'),
          ],
        ),
        const SizedBox(
          width: 30,
        ),
        Image.asset(
          'images/clinic.jpg',
          width: 100,
          height: 100,
          fit: BoxFit.fill,
        ),
      ],
    );
  }
}
