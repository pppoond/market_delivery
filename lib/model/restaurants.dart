import 'package:flutter/material.dart';
import './menu.dart';

class Restaurant {
  final String id;
  final String title;
  final int mobile;
  final String image;
  bool isFavorite;
  List<MenuItem> menu;

  Restaurant({
    required this.id,
    required this.title,
    required this.mobile,
    required this.image,
    required this.menu,
    this.isFavorite = false,
  });
}

class Restaurants with ChangeNotifier {
  List<Restaurant> get restaurants {
    return [..._restaurants];
  }

  List<Restaurant> get favorite {
    final favoriteOnly = _restaurants.where((res) => res.isFavorite).toList();
    return [...favoriteOnly];
  }

  Restaurant findById(String id) {
    return _restaurants.firstWhere((res) => res.id == id);
  }

  void toggleFavorite(String resId, bool isFavorite) {
    final existingIndex = _restaurants.indexWhere((res) => res.id == resId);
    // print(existingIndex);
    if (existingIndex >= 0) {
      _restaurants[existingIndex].isFavorite = !isFavorite;
    }
    notifyListeners();
  }

  List<MenuItem> get menuItem {
    List<MenuItem> items = [];

    _restaurants.forEach((restaurant) {
      restaurant.menu.forEach((menu) {
        items.add(menu);
      });
    });
    return [...items];
  }

  List<Restaurant> _restaurants = [
    Restaurant(
        id: "100",
        title: "ร้านอาหารญี่ปุ่น",
        mobile: 0123456789,
        isFavorite: false,
        image:
            "https://cdn.pixabay.com/photo/2016/04/26/03/55/salmon-1353598_1280.jpg",
        menu: [
          MenuItem(
              id: "1",
              title: "ข้าวหน้าปลาแซลมอน",
              price: 240.00,
              restaurantTitle: "ร้านอาหารญี่ปุ่น",
              restaurantId: "100",
              image:
                  "https://i1.wp.com/unfussyepicure.com/wp-content/uploads/2015/04/sake-don-1.jpg?fit=1200%2C900&ssl=1"),
          MenuItem(
              id: "2",
              title: "ราเมงน้ำข้นหมูชาชู",
              price: 170.00,
              restaurantTitle: "ร้านอาหารญี่ปุ่น",
              restaurantId: "100",
              image:
                  "https://images.unsplash.com/photo-1557872943-16a5ac26437e?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=716&q=80"),
          MenuItem(
              id: "3",
              title: "ซูชิรวมชุดเล็ก",
              price: 320.00,
              restaurantTitle: "ร้านอาหารญี่ปุ่น",
              restaurantId: "100",
              image:
                  "https://cdn.pixabay.com/photo/2015/10/06/19/10/sushi-975075_1280.jpg"),
          MenuItem(
              id: "4",
              title: "สเต๊กปลาแซลมอน",
              price: 225.00,
              restaurantTitle: "ร้านอาหารญี่ปุ่น",
              restaurantId: "100",
              image:
                  "https://cdn.pixabay.com/photo/2015/04/08/13/13/food-712665_1280.jpg"),
        ]),
    Restaurant(
        id: "200",
        title: "ร้านอาหารเกาหลี",
        mobile: 0123456789,
        isFavorite: false,
        image:
            "https://images.pexels.com/photos/2313686/pexels-photo-2313686.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        menu: [
          MenuItem(
              id: "1",
              title: "ไก่ทอดเกาหลี",
              price: 220.00,
              restaurantTitle: "ร้านอาหารเกาหลี",
              restaurantId: "200",
              image:
                  "https://images.pexels.com/photos/2338407/pexels-photo-2338407.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"),
          MenuItem(
              id: "2",
              title: "ซุนดูบูจิเก(ซุปเต้าหู้อ่อน)",
              price: 150.00,
              restaurantTitle: "ร้านอาหารเกาหลี",
              restaurantId: "200",
              image:
                  "https://media-cdn.tripadvisor.com/media/photo-s/0e/ff/3a/0c/sundubu-jjigae-korean.jpg"),
          MenuItem(
              id: "3",
              title: "ซอลลองทัง(ซุปกระดูกวัว)",
              price: 170.00,
              restaurantTitle: "ร้านอาหารเกาหลี",
              restaurantId: "200",
              image:
                  "https://www.koreanbapsang.com/wp-content/uploads/2013/02/DSC5973-2-e1569821046791.jpg"),
          MenuItem(
              id: "4",
              title: "ต๊อกบกกี",
              price: 230.00,
              restaurantTitle: "ร้านอาหารเกาหลี",
              restaurantId: "200",
              image:
                  "https://cdn.pixabay.com/photo/2017/11/27/12/07/toppokki-2981210_1280.jpg"),
        ]),
    Restaurant(
        id: "300",
        title: "ร้านอาหารอิตาเลี่ยน",
        mobile: 0123456789,
        isFavorite: false,
        image:
            "https://cdn.pixabay.com/photo/2020/05/17/04/22/pizza-5179939_1280.jpg",
        menu: [
          MenuItem(
              id: "1",
              title: "ลาซานญ่า",
              price: 280.00,
              restaurantTitle: "ร้านอาหารอิตาเลี่ยน",
              restaurantId: "300",
              image:
                  "https://cdn.pixabay.com/photo/2021/02/06/11/51/food-5987888_1280.jpg"),
          MenuItem(
              id: "2",
              title: "พิซซ่าแป้งบางถาดกลาง",
              price: 260.00,
              restaurantTitle: "ร้านอาหารอิตาเลี่ยน",
              restaurantId: "300",
              image:
                  "https://cdn.pixabay.com/photo/2018/03/04/20/05/pizza-3199081_1280.jpg"),
          MenuItem(
              id: "3",
              title: "สปาเก็ตตี้คาโบนาร่า",
              price: 232.00,
              restaurantTitle: "ร้านอาหารอิตาเลี่ยน",
              restaurantId: "300",
              image:
                  "https://cdn.pixabay.com/photo/2018/11/10/00/38/pasta-3805772_1280.jpg"),
          MenuItem(
              id: "4",
              title: "ทิรามิซุ",
              price: 160.00,
              restaurantTitle: "ร้านอาหารอิตาเลี่ยน",
              restaurantId: "300",
              image:
                  "https://cdn.pixabay.com/photo/2021/04/12/10/42/tiramisu-6172170_1280.jpg"),
        ]),
  ];
}
