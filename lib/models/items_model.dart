class Items {
  final String img;
  final String title;
  final String subTitle;

  ///
  Items({
    required this.img,
    required this.title,
    required this.subTitle,
  });
}

List<Items> listOfItems = [
  Items(
    img: "assets/1.png",
    title: "Rappelez-Vous de Prendre \nVos Médicaments",
    subTitle:
        "Configurez des Rappels Pour\n Vous Aider à Prendre Votre \nMédicament à Temps.",
  ),
  Items(
    img: "assets/2.png",
    title: "Cherchez-vous la pharamcie",
    subTitle:
        "Recherchez les Pharmacies\n Ouvertes à Proximité de Chez vVous.",
  ),
  Items(
    img: "assets/3.png",
    title: "Trouver un Médecin qui Correspond à Vos Besoins",
    subTitle: "Trouver des Médecins Qualifiés\n Pour Obtenir des Informations\n Sur Votre Etat de santé.",
  ),
];
