import 'package:flutter/material.dart';
import 'package:task/add_item/item.dart';
import 'package:task/add_item/item_model.dart';
import 'package:task/details/details_screen/details_page.dart';
import 'package:task/add_item/add_item_screen.dart';
import 'package:provider/provider.dart';

import 'package:task/favorite/favorite_model.dart';
import '../details/details_widget/favorite.dart';
import '../profile/profile_page/profile_page.dart';
import '../profile/user_model.dart';
import '../main.dart'; // استيراد ThemeProvider

class DashboardScreen extends StatelessWidget {
  static String id = 'dashboardScreen';

  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final i = Provider.of<FavoriteModel>(context).fav.length;
    final profileImage = Provider.of<UserModel>(context).user?.image;
    final items = Provider.of<ItemModel>(context);
    final themeProvider = Provider.of<ThemeProvider>(context); // الوصول إلى ThemeProvider

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddItemScreen()));
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text("DashBoard"),
        actions: [
          Stack(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  )),
              CircleAvatar(
                child: Text("$i"),
                radius: 10,
              ),
            ],
          ),
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>  ProfilePage()));
              },
              icon: profileImage == null
                  ? const Icon(Icons.account_box)
                  : CircleAvatar(
                child: ClipOval(
                  child: Image.file(
                    profileImage,
                    fit: BoxFit.cover,
                    height: 50,
                    width: 50,
                  ),
                ),
              )),
          // إضافة زر تبديل الوضع هنا
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Switch.adaptive(
              value: Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark,
              onChanged: (value) {
                Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
              },
              thumbIcon: MaterialStateProperty.resolveWith<Icon?>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.selected)) {
                    return const Icon(Icons.brightness_2); // أيقونة الهلال للوضع الداكن
                  }
                  return const Icon(Icons.wb_sunny); // أيقونة الشمس للوضع الفاتح
                },
              ),
            ),
          ),
        ],
      ),
      body: items.items.isNotEmpty
          ? GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 10),
        itemCount: items.items.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              items.selectItem(Item(
                  images: items.items[index].images,
                  title: items.items[index].title,
                  body: items.items[index].body,
                  favorite: items.items[index].favorite,
                   price: items.items[index].price));
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>  DetailsPage()));
            },
            child: SizedBox(
              child: Column(
                children: [
                  Image.file(
                    items.items[index].images.first,
                    height: 125,
                    width: 125,
                    fit: BoxFit.cover,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(items.items[index].title),
                      FavoriteWidget(
                        index: items.items.indexOf(items.items[index]),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      )
          : const Center(child: Text("No Items")),
    );
  }
}



