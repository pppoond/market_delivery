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
    items.shuffle();
    return [...items];
  }

  List<Restaurant> _restaurants = [
    Restaurant(
        id: "100",
        title: "ร้านผลไม้",
        mobile: 0123456789,
        isFavorite: false,
        image:
            "https://images.unsplash.com/photo-1610832958506-aa56368176cf?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1050&q=80",
        menu: [
          MenuItem(
              id: "1",
              title: "สตรอว์เบอร์รี",
              price: 240.00,
              restaurantTitle: "ร้านผลไม้",
              restaurantId: "100",
              image:
                  "https://images.unsplash.com/photo-1575808142341-e39853744dbd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=542&q=80"),
          MenuItem(
              id: "2",
              title: "เงาะ",
              price: 170.00,
              restaurantTitle: "ร้านผลไม้",
              restaurantId: "100",
              image:
                  "https://images.unsplash.com/photo-1602615446784-00a9a34e3d0b?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=667&q=80"),
          MenuItem(
              id: "3",
              title: "มะม่วง",
              price: 320.00,
              restaurantTitle: "ร้านผลไม้",
              restaurantId: "100",
              image:
                  "https://images.unsplash.com/photo-1592309405331-360092a17a82?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=375&q=80"),
          MenuItem(
              id: "4",
              title: "องุ่น",
              price: 225.00,
              restaurantTitle: "ร้านอาหารญี่ปุ่น",
              restaurantId: "100",
              image:
                  "https://images.unsplash.com/photo-1578829779691-99b60bd8c7be?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=661&q=80"),
        ]),
    Restaurant(
        id: "200",
        title: "ร้านเนื้อ",
        mobile: 0123456789,
        isFavorite: false,
        image:
            "https://images.unsplash.com/photo-1597417321971-45e034f7a993?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1246&q=80",
        menu: [
          MenuItem(
              id: "1",
              title: "เนื้อหมู",
              price: 220.00,
              restaurantTitle: "ร้านเนื้อ",
              restaurantId: "200",
              image:
                  "https://images.unsplash.com/photo-1611059263765-f57653f3bba3?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=667&q=80"),
          MenuItem(
              id: "2",
              title: "เนื้อไก่",
              price: 150.00,
              restaurantTitle: "ร้านเนื้อ",
              restaurantId: "200",
              image:
                  "https://images.unsplash.com/photo-1600180786608-28d06391d25c?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80"),
          MenuItem(
              id: "3",
              title: "เนื้อวัว",
              price: 170.00,
              restaurantTitle: "ร้านเนื้อ",
              restaurantId: "200",
              image:
                  "https://images.unsplash.com/photo-1603048297172-c92544798d5a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1050&q=80"),
        ]),
    Restaurant(
        id: "300",
        title: "ร้านผัก",
        mobile: 0123456789,
        isFavorite: false,
        image:
            "https://www.prachachat.net/wp-content/uploads/2021/02/S__2457791.jpg",
        menu: [
          MenuItem(
              id: "1",
              title: "ผักคะน้า",
              price: 280.00,
              restaurantTitle: "ร้านผัก",
              restaurantId: "300",
              image:
                  "https://s359.kapook.com/pagebuilder/0ccded1e-ef03-46d3-929f-4b202065c58d.jpg"),
          MenuItem(
              id: "2",
              title: "ผักบุ้ง",
              price: 260.00,
              restaurantTitle: "ร้านผัก",
              restaurantId: "300",
              image:
                  "https://lh3.googleusercontent.com/proxy/68AfGXAc51jAyuAve-YtyF6RTFi3CIu5AaYnhyCkGXk4t7Ql4UCp9WlM0l-tM3BmZSXvC1XaU7io29RcYbaZeXzxGXx7HUw4yDRVaeol77GgA4a58DublRRDEaTA_3I"),
          MenuItem(
              id: "3",
              title: "ผักกาดหอม",
              price: 232.00,
              restaurantTitle: "ร้านผัก",
              restaurantId: "300",
              image:
                  "https://lh3.googleusercontent.com/proxy/AgZW3nvM8D9WIDpHCbf2HqFMFBQ7ggqsTiK7IYaaQCUGav1lNagHzFMNT73eP_Zo-YgIJtwx3u30bb7PembDle6Qa73XFnokVG9Kq6N1bmi6"),
          MenuItem(
              id: "4",
              title: "ผักชี",
              price: 160.00,
              restaurantTitle: "ร้านผัก",
              restaurantId: "300",
              image:
                  "https://obs.line-scdn.net/0hwjdQj-RyKEVZKAOknaNXEmN-KypqRDtGPR55RgVGdnEhEWhBbRs1K3p8dSJwGG8bME9nInUhM3QkSmxEZBw1/w644"),
        ]),
  ];
}
