class MenuItem {
  final String name;
  final String description;
  final String
  baseIcon; // "cow", "chicken", "fish", "hotdog", "utensils", "drink", "salad", "fries", "onion_rings"
  final Map<String, int> prices;
  final Map<String, String>? descriptions;

  const MenuItem({
    required this.name,
    required this.description,
    required this.baseIcon,
    required this.prices,
    this.descriptions,
  });
}

class MenuCategory {
  final String title;
  final String subtitle;
  final String icon; // "hamburger", "star", "utensils", "drink", "hotdog"
  final List<MenuItem> items;

  const MenuCategory({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.items,
  });
}

final List<MenuCategory> menuCategories = [
  const MenuCategory(
    title: "Smash Burgerek",
    subtitle: "Smash",
    icon: "hamburger",
    items: [
      MenuItem(
        name: "Black Smash Burger",
        description:
            "100% marhahús patty, angol cheddar sajt, pirított zsemle, csemegeuborka, ketchup, mustár",
        baseIcon: "cow",
        prices: {"Single": 1600, "Double": 2350, "Triple": 3100},
      ),
      MenuItem(
        name: "Oklahoma Black Smash",
        description:
            "100% marhahús hagymával, angol cheddar sajt, pirított zsemle, csemegeuborka, ketchup, mustár",
        baseIcon: "cow",
        prices: {"Single": 1600, "Double": 2350, "Triple": 3100},
      ),
      MenuItem(
        name: "Soho Smash Burger",
        description:
            "100% marhahús patty, angol cheddar sajt, pirított zsemle, csemegeuborka, Black Cab szósz",
        baseIcon: "cow",
        prices: {"Single": 1600, "Double": 2350, "Triple": 3100},
      ),
      MenuItem(
        name: "Oklahoma Soho Smash",
        description:
            "100% marhahús hagymával, angol cheddar sajt, pirított zsemle, csemegeuborka, Black Cab szósz",
        baseIcon: "cow",
        prices: {"Single": 1600, "Double": 2350, "Triple": 3100},
      ),
    ],
  ),
  const MenuCategory(
    title: "Klasszikusok & Köretek",
    subtitle: "Klasszikus",
    icon: "hamburger",
    items: [
      MenuItem(
        name: "Marhahúsos Burger",
        description:
            "100% marhahús, pirított zsemle, csemegeuborka, fehér hagyma, jalapeno paprika, aprított jégsaláta, paradicsom, ketchup, mustár, majonéz, BBQ szósz",
        baseIcon: "cow",
        prices: {
          "Normál": 1700,
          "Nagy": 2500,
          "Normál Dupla": 3100,
          "Nagy Dupla": 4000,
        },
      ),
      MenuItem(
        name: "Házi sültkrumpli",
        description:
            "Helyben szeletelt, koleszterinmentes mogyoróolajban ropogósra sütött burgonya",
        baseIcon: "fries",
        prices: {"Kicsi": 600, "Normál": 900, "Nagy": 1200},
      ),
      MenuItem(
        name: "Citromos-zöldfűszeres csirkemell",
        description:
            "Roston sült citromos-zöldfűszeres 100% csirkemell, zsemle, csemegeuborka, fehér hagyma, jalapeno paprika, aprított jégsaláta, paradicsom, ketchup, mustár, majonéz, BBQ szósz",
        baseIcon: "chicken",
        prices: {"Normál": 1700, "Nagy": 2500},
      ),
      MenuItem(
        name: "Black Cab BBQ csirkemell",
        description:
            "Roston sült 100% csirkemell, zsemle, csemegeuborka, fehér hagyma, jalapeno paprika, aprított jégsaláta, paradicsom, ketchup, mustár, majonéz, BBQ szósz",
        baseIcon: "chicken",
        prices: {"Normál": 1700, "Nagy": 2500},
      ),
    ],
  ),
  const MenuCategory(
    title: "Specialitások",
    subtitle: "Specialitások",
    icon: "star",
    items: [
      MenuItem(
        name: "Cabbie Burger",
        description:
            "100% marhahús, grillezett bacon, angol cheddar sajt, pirított zsemle, mustár, ketchup, jalapeno, paradicsom, fehér hagyma, csemegeuborka, jégsaláta, majonéz, BBQ szósz",
        baseIcon: "cow",
        prices: {
          "Normál": 2300,
          "Nagy": 3100,
          "Normál Dupla": 3700,
          "Nagy Dupla": 4600,
        },
      ),
      MenuItem(
        name: "Cheesy Soho burger",
        description:
            "100% marhahús, dupla adag angol cheddar sajt, burgerszósz, aprított jégsaláta, fehér hagyma, csemegeuborka",
        baseIcon: "cow",
        prices: {
          "Normál": 2300,
          "Nagy": 3100,
          "Normál Dupla": 3700,
          "Nagy Dupla": 4600,
        },
      ),
      MenuItem(
        name: "Smoky burger",
        description:
            "100% marhahús, angol cheddar sajt, pirított bacon, majonéz, pirított hagyma, aprított jégsaláta, paradicsomkarika, fehér hagyma, jalapeno paprika, BBQ szósz",
        baseIcon: "cow",
        prices: {
          "Normál": 2300,
          "Nagy": 3100,
          "Normál Dupla": 3700,
          "Nagy Dupla": 4600,
        },
      ),
      MenuItem(
        name: "Különleges Hot-Dog",
        description:
            "Fehér grillkolbász, hot dog kifli, mustár, pirított hagyma, majonéz, BBQ szósz",
        baseIcon: "hotdog",
        prices: {"Cab Dog": 1800, "Brixton Dog": 1900},
        descriptions: {
          "Cab Dog":
              "Fehér grillkolbász, hot dog kifli, mustár, pirított hagyma, majonéz, BBQ szósz",
          "Brixton Dog":
              "Sajtos-jalapenos grillkolbász, ketchup, mustár, pirított hagyma, jalapeno paprika, reszelt angol cheddar sajt",
        },
      ),
      MenuItem(
        name: "Giga Double Decker",
        description:
            "A szörnyeteg: 600 g 100% marhahús, 100 g grillezett bacon, 100 g angol cheddar sajt, pirított zsemle, zöldségek és szószok",
        baseIcon: "cow",
        prices: {"Giga": 7100},
      ),
      MenuItem(
        name: "Lazac Burger",
        description:
            "100% norvég lazachús, jégsaláta, remulád mártás, paradicsom, pirított zsemle",
        baseIcon: "fish",
        prices: {"Normál": 3000, "Nagy": 3600},
      ),
    ],
  ),
  const MenuCategory(
    title: "Finomságok",
    subtitle: "Finomságok",
    icon: "utensils",
    items: [
      MenuItem(
        name: "Klasszikus Hot-Dog",
        description:
            "Prémium hot dog kifli pirított hagymával, mustárral, majonézzel és BBQ szósszal. Választható feltéttel.",
        baseIcon: "hotdog",
        prices: {"Frankfurti virsli": 1600, "Grillkolbász": 1800},
      ),
      MenuItem(
        name: "Friss Saláták",
        description:
            "Ropogós friss salátaágy, paradicsom, uborka. Választható feltéttel és öntettel (Csirkével +1200 Ft).",
        baseIcon: "salad",
        prices: {"Black Cab": 2000, "Kéksajtos": 2200, "Lazacos": 3800},
      ),
      MenuItem(
        name: "Meal Deal 1",
        description:
            "Kis sültkrumpli + Coca-Cola (bármely burger mellé kérhető)",
        baseIcon: "fries",
        prices: {"Menü": 1000},
      ),
      MenuItem(
        name: "Meal Deal 2",
        description:
            "Kis sültkrumpli + Rostos vagy angol üdítő (bármely burger mellé kérhető)",
        baseIcon: "fries",
        prices: {"Menü": 1200},
      ),
    ],
  ),
  const MenuCategory(
    title: "Italok",
    subtitle: "Italok",
    icon: "drink",
    items: [
      MenuItem(
        name: "Coca-Cola",
        description: "Klasszikus szénsavas üdítőital (0.33l)",
        baseIcon: "drink",
        prices: {"Dobozos": 600},
      ),
      MenuItem(
        name: "Angol Üdítők",
        description:
            "Különleges angol szénsavas üdítőital különlegességek (0.33l)",
        baseIcon: "drink",
        prices: {"Dobozos": 800},
      ),
      MenuItem(
        name: "Cappy Gyümölcslevek",
        description: "Rostos és szűrt gyümölcslevek (0.25l)",
        baseIcon: "drink",
        prices: {"Üveges": 800},
      ),
      MenuItem(
        name: "Ásványvíz",
        description: "Naturaqua szénsavas / szénsavmentes ásványvíz (0.5l)",
        baseIcon: "drink",
        prices: {"Palack": 500},
      ),
      MenuItem(
        name: "Sörök",
        description: "Minőségi dobozos és üveges sörök",
        baseIcon: "drink",
        prices: {"0.33l": 1200, "0.5l": 1900},
      ),
      MenuItem(
        name: "Ciderek",
        description: "Prémium cider különlegességek (0.5l)",
        baseIcon: "drink",
        prices: {"Üveges": 1900},
      ),
    ],
  ),
];
