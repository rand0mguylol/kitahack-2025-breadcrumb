import 'package:breadcrumbs/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';

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
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    Text(
                      "Brands",
                    ),
                    Text(
                      "Restaurant",
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
            // height: MediaQuery.of(context).size.height *,
            child: TabBarView(
              controller: _tabController,
              children: [
                // Wrap(
                //     alignment: WrapAlignment.center,
                //     runSpacing: 12,
                //     spacing: 24,
                //     children: [_buildCard(context), _buildCard(context)]),
                GridView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns
                    crossAxisSpacing: 12, // Horizontal spacing between items
                    mainAxisSpacing: 16, // Vertical spacing between items
                    childAspectRatio: 0.6, // Width-to-height ratio of each item
                  ),
                  itemCount:
                      nissin.length, // Replace with the actual number of items
                  itemBuilder: (context, index) {
                    final item = nissin[index];
                    return _buildCard(
                      context,
                      name: item['name']!,
                      image: item['image']!,
                      calories: item['calories']!,
                      brand: 'Nissin',
                    ); // Build each card
                  },
                ),
                GridView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns
                    crossAxisSpacing: 12, // Horizontal spacing between items
                    mainAxisSpacing: 16, // Vertical spacing between items
                    childAspectRatio: 0.6, // Width-to-height ratio of each item
                  ),
                  itemCount:
                      LJ.length, // Replace with the actual number of items
                  itemBuilder: (context, index) {
                    final item = LJ[index];
                    return _buildCard(
                      context,
                      name: item['name']!,
                      image: item['image']!,
                      calories: item['calories']!,
                      brand: 'La Juceria',
                    ); // Build each card
                  },
                )
                // const Center(
                //   child: Text(
                //     "Feature is coming soon",
                //     style: TextStyle(color: Colors.black),
                //   ),
                // )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context,
      {String image = 'assets/images/meal/phone_1.png',
      String name = "Spicy Chicken Mcdeluxe",
      String calories = "1000",
      String brand = 'Mcdonald'}) {
    return Container(
      clipBehavior: Clip.antiAlias,
      width: 166,
      height: 280,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            height: 166,
            child: ClipRRect(
              clipBehavior: Clip.hardEdge,
              child: Image.asset(
                image,
                // 'assets/images/meal/phone_1.png',
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              name,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
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
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text("$calories kcal",
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                    fontStyle: FontStyle.italic)),
          )
        ],
      ),
    );
  }
}
