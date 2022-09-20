import 'package:flutter/material.dart';
import 'package:what_to_eat/presentation/widgets/bottom_navigation.dart';
import 'package:what_to_eat/utils/api_hub.dart';

import '../../models/meal_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: HomeScreen());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('What to eat?'),
        leading: CircleAvatar(
          backgroundImage: const NetworkImage(
              'https://www.themealdb.com/images/media/meals/58oia61564916529.jpg'),
        ),
      ),
      bottomNavigationBar: const BottomNavigation(),
      body: MealGenerator(),
    );
  }
}

class MealGenerator extends StatelessWidget {
  const MealGenerator({super.key});
  Future<Meal> fetchRandomMeal() async {
    return await ApiHub().fetchRandomMeal();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchRandomMeal(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Meal data = snapshot.data! as Meal;
            return ListView(
              shrinkWrap: true,
              children: [
                MealGeneratorTile(
                    mealTitle: data.strMeal,
                    mealImage: data.strMealThumb,
                    mealArea: data.strArea),
                MealGeneratorTile(
                    mealTitle: data.strMeal,
                    mealImage: data.strMealThumb,
                    mealArea: data.strArea),
              ],
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return const CircularProgressIndicator();
        });
  }
}

class MealGeneratorTile extends StatelessWidget {
  const MealGeneratorTile(
      {super.key,
      required this.mealTitle,
      required this.mealImage,
      required this.mealArea});
  final String mealTitle;
  final String mealImage;
  final String mealArea;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 250,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(mealImage),
          fit: BoxFit.cover,
          colorFilter:
              ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken),
        ),
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 15,
            left: 10,
            child: SizedBox(
              width: 100,
              child: Text(mealTitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ),
          Positioned(
            top: 35,
            left: 10,
            child: Text(
              mealArea,
              style: const TextStyle(
                color: Color.fromARGB(255, 197, 197, 197),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
