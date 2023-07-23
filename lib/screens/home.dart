import 'package:flutter/material.dart';

import '../widget/NavBar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[300],
        title: const Center(child: Text('Billventory')),
      ),
      drawer: const NavBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome to Billventory',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Text(
                'Your Billing and Inventory Management Solution',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              const Text(
                'About Billventory',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Billventory is a cross-platform app that provides powerful features for managing your billing and inventory. Whether you run a small business or a large enterprise, Billventory simplifies your operations and helps you stay organized.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              const Text(
                'Key Features',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildFeatureItem(
                    image: 'assets/images/inventory.jpg',
                    title: 'Inventory Management',
                    description:
                    'Efficiently manage your inventory, track stock levels, and receive notifications for low stock items.',
                  ),
                  _buildFeatureItem(
                    image: 'assets/images/billing.png',
                    title: 'Billing and Invoicing',
                    description:
                    'Generate professional invoices, process payments, and keep track of your sales transactions.',
                  ),
                  _buildFeatureItem(
                    image: 'assets/images/reports.jpg',
                    title: 'Reporting and Analytics',
                    description:
                    'Gain insights into your business performance with detailed reports and analytics.',
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem({required String image, required String title, required String description}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            image,
            width: 40,
            height: 40,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}




// import 'package:flutter/material.dart';
//
// import '../widget/NavBar.dart';
//
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.purple[300],
//         title: const Center(child: Text('Billventory')),
//       ),
//       drawer: const NavBar(),
//       body: SingleChildScrollView(
//         child: Container(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text(
//                 'Welcome to Billventory',
//                 style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 20),
//               const Text(
//                 'Your Billing and Inventory Management Solution',
//                 style: TextStyle(fontSize: 18),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 40),
//               const Text(
//                 'About Billventory',
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 10),
//               const Text(
//                 'Billventory is a cross-platform app that provides powerful features for managing your billing and inventory. Whether you run a small business or a large enterprise, Billventory simplifies your operations and helps you stay organized.',
//                 style: TextStyle(fontSize: 16),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 40),
//               const Text(
//                 'Key Features',
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 10),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   _buildFeatureItem(
//                     icon: Icons.inventory,
//                     title: 'Inventory Management',
//                     description:
//                     'Efficiently manage your inventory, track stock levels, and receive notifications for low stock items.',
//                   ),
//                   _buildFeatureItem(
//                     icon: Icons.point_of_sale,
//                     title: 'Billing and Invoicing',
//                     description:
//                     'Generate professional invoices, process payments, and keep track of your sales transactions.',
//                   ),
//                   _buildFeatureItem(
//                     icon: Icons.analytics,
//                     title: 'Reporting and Analytics',
//                     description:
//                     'Gain insights into your business performance with detailed reports and analytics.',
//                   ),
//                   _buildFeatureItem(
//                     icon: Icons.settings,
//                     title: 'Customization and Settings',
//                     description:
//                     'Customize the app to fit your business needs and manage settings such as taxes, discounts, and more.',
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildFeatureItem({required IconData icon, required String title, required String description}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 12),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(icon, size: 30),
//           const SizedBox(width: 10),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   'Billventory is a comprehensive billing and inventory management app designed to streamline and simplify your business operations. With Billventory, you can efficiently manage your inventory, track stock levels, and receive notifications for low stock items. The app also provides powerful billing and invoicing features, allowing you to generate professional invoices, process payments, and keep track of your sales transactions.\n\nOne of the key strengths of Billventory is its robust reporting and analytics capabilities. You can gain valuable insights into your business performance through detailed reports and analytics, helping you make informed decisions to optimize your operations and drive growth.\n\nCustomization is at the core of Billventory, enabling you to tailor the app to fit your specific business needs. You can easily configure settings such as taxes, discounts, and other parameters to align with your business requirements.\n\nBillventory is a cross-platform app, ensuring accessibility and flexibility across various devices and operating systems. Whether you run a small business or a large enterprise, Billventory is designed to scale and adapt to your business size and complexity.\n\nExperience the power of efficient billing and inventory management with Billventory. Simplify your processes, stay organized, and take control of your business with this all-in-one solution.',
//                   style: TextStyle(fontSize: 16),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
//
// import '../widget/NavBar.dart';
//
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.purple[300],
//         title: const Center(child: Text('Billventory')),
//       ),
//       drawer: const NavBar(),
//       body: Container(
//         child: Center(child: Text('Welcome', style: TextStyle(fontSize: 30))),
//       ),
//
//       // endDrawer:Directionality(textDirection: TextDirection.rtl,
//       //     child: Drawer(
//       //     )) ,
//     );
//   }
// }
