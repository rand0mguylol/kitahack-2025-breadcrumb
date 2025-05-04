import 'package:breadcrumbs/constants/dropdown/form.dart';
import 'package:breadcrumbs/router/routes.dart';
import 'package:breadcrumbs/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

const LJ = [
  {
    'image': 'assets/images/restaurant/lj1.png',
    'name': 'Pomegranate Salmon Salad',
    'calories': '643'
  },
  {
    'image': 'assets/images/restaurant/lj2.png',
    'name': 'Caesar Salad',
    'calories': '696'
  },
  {
    'image': 'assets/images/restaurant/lj3.png',
    'name': 'Keto Nyonya Laksa Goreng Chciken',
    'calories': '507'
  },
];

const nissin = [
  {
    'image': 'assets/images/brand/nissin1.png',
    'name': 'Cup Noodles Chicken',
    'calories': '290'
  },
  {
    'image': 'assets/images/brand/nissin2.png',
    'name': 'Cup Noodles Stir Fry Teriyaki Chicken',
    'calories': '380'
  },
  {
    'image': 'assets/images/brand/nissin3.png',
    'name': 'Top Ramen Bowl Beef',
    'calories': '380'
  },
];

class MarketplaceHomeScreen extends StatefulWidget {
  const MarketplaceHomeScreen({super.key});

  @override
  State<MarketplaceHomeScreen> createState() => _MarketplaceHomeScreenState();
}

class _MarketplaceHomeScreenState extends State<MarketplaceHomeScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final double itemWidth = (size.width - 12 - 16) / 2;
    final double itemHeight = itemWidth * 1.9;

    return Scaffold(
      appBar: const CustomAppBar(
        title: "Marketplace",
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            width: double.infinity,
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              spacing: 16,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200], // Background color
                      borderRadius:
                          BorderRadius.circular(30), // Rounded corners
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: "Feature coming soon...",
                        prefixIcon: Icon(Icons.search),
                        border: InputBorder.none, // Remove default border
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 20), // Padding inside the field
                      ),
                    ),
                  ),
                ),
                TabBar(
                  controller: _tabController,
                  labelColor: Colors.white,
                  labelPadding: EdgeInsets.all(5),
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  dividerHeight: 0,
                  tabs: const <Widget>[
                    // Text(
                    //   "Brands",
                    // ),
                    Text(
                      "Food",
                    )
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // GridView.count(
                //   shrinkWrap: true,
                //   padding:
                //       const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                //   mainAxisSpacing: 12,
                //   crossAxisSpacing: 16,
                //   crossAxisCount: 2,
                //   childAspectRatio: itemWidth / itemHeight,
                //   children: nissin
                //       .map((element) => _buildCard(
                //             context,
                //             name: element['name']!,
                //             image: element['image']!,
                //             calories: element['calories']!,
                //             brand: 'Nissin',
                //           ))
                //       .toList(),
                // ),

                GridView.count(
                  shrinkWrap: true,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 16,
                  crossAxisCount: 2,
                  childAspectRatio: itemWidth / itemHeight,
                  children: LJList.map((element) => _buildCard(
                        context,
                        id: element['id'],
                        name: (element['title']) ?? '',
                        image: element['image'] ?? '',
                        calories: element['nutrition']['calories'].toString(),
                        brand: 'La Juceria',
                      )).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context,
      {required String id,
      String image = 'assets/images/meal/phone_1.png',
      String name = "Spicy Chicken Mcdeluxe",
      String calories = "1000",
      String brand = 'Mcdonald'}) {
    return GestureDetector(
      onTap: () {
        context.push(Routes.marketplaceRoute.marketplaceDetail(foodId: id));
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        width: 166,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            LayoutBuilder(
              builder: (builder, constraints) {
                final width = constraints.maxWidth;
                return SizedBox(
                  child: ClipRRect(
                    clipBehavior: Clip.hardEdge,
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                      width: width,
                      height: width,
                      // he
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                brand,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 16),
              child: Text("$calories kcal",
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontStyle: FontStyle.italic)),
            )
          ],
        ),
      ),
    );
  }
}
