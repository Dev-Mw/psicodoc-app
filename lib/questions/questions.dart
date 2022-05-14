



final Map<String, int> answers = {};
final List<Questions> questions = [
  Questions("Tristeza", [
    "No me siento triste.",
    "Me siento triste gran parte del tiempo.",
    "Estoy triste todo el tiempo.",
    "Estoy tan triste o soy tan feliz que no puedo soportarlo."
  ], [Number_Answers.one, Number_Answers.three, Number_Answers.three, Number_Answers.four]),
  Questions("Pesimismo", [
    "No estoy desalentado respecto de mi futuro.",
    "Me siento más desalentado respecto de mi futuro que lo que solia estarlo.",
    "No espero que las cosas funcionen para mí.",
    "Siento que no hay esperanza para mi futuro y que sólo se puede empeorar."
  ], [Number_Answers.one, Number_Answers.three, Number_Answers.three, Number_Answers.four]),
  Questions("Fracaso", [
    "No me siento triste 3",
    "Me siento triste gran parte del tiempo",
    "Estoy triste todo el tiempo",
    "Estoy tan triste o soy tan feliz que no puedo soportarlo"
  ], [Number_Answers.one, Number_Answers.three, Number_Answers.three, Number_Answers.four])
];


List<Widget> _questions() {
  final q = [];
  for (var i = 0; i < questions.length; i++){
    q.insert(i, i);
  }
}