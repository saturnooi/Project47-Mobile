import 'package:flutter/material.dart';

class HomeInfo extends StatelessWidget {
  const HomeInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: const [
            Text('We Smile+ Clinic'),
            Text('เปิดบริการ 10.00 - 20.00 น.'),
            Text('ตั้งอยู่ที่ 321 ถ.เฉลิมพระเกียรติ'),
            Text('แขวงหนองบอน เขตประเวศ'),
            Text('กรุงเทพ 10520'),
          ],
        ),
        const SizedBox(
          width: 20,
        ),
        Image.asset(
          'images/clinic.jpg',
          width: 140,
          height: 200,
          fit: BoxFit.fill,
        ),
      ],
    );
  }
}
