import 'package:flutter/material.dart';
import 'package:museo/constants/colors.dart';
import 'package:museo/extensions/buildcontext/loc.dart';
import 'package:museo/gen/assets.gen.dart';

class SectionsView extends StatelessWidget {
  const SectionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.sections),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            // TODO -> Get string by L10N
            const Center(
              child: Text(
                'A EXPOSIÇÃO',
                style: TextStyle(
                  color: mainBlue,
                  fontSize: 28,
                ),
              ),
            ),
            // About exhibition
            const SizedBox(height: 10),
            const Text(
              // TODO -> Get string by L10N
              'O projeto museográfico é moderno e valoriza as peças de maneira segura e confortável para o visitante. O Projeto luminotécnico é todo em led e os ambientes são climatizados, o que garante uma visitação agradável em qualquer época do ano. É totalmente acessível para pessoas com deficiência física e com mobilidade reduzida.',
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 10),
            Image.asset(Assets.sections.exhibition.path),
            const SizedBox(height: 10),
            const Text(
              'O acervo do Museu Oceanográfico Univali tem mais de 200.00 peças e a exposição apresenta menos de 1% delas, proporcionando ao visitante um panorama da biodiversidade marinha brasileira. Além disso, animais vivos em aquários acrescentam vida e movimento ao circuito expositivo. O museu está dividido em sete diferentes alas, conforme os seguintes temas:',
              textAlign: TextAlign.justify,
            ),
            // Blue Section
            const SizedBox(height: 10),
            const Text(
              'Ala azul - Surgimento da vida e da Oceanografia',
              style: TextStyle(
                color: mainBlue,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Esta ala conta a história da vida através de fósseis de cada era geológica. Peças históricas contextualizam o fascínio das antigas civilizações pelo mar, contando como foram as grandes navegações de descobrimento e apresentando os grandes expoentes da oceanografia.  Também são apresentadas as modernas tecnologias de exploração oceânica.',
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 10),
            Image.asset(Assets.sections.blue.path),
            // Red Section
            const SizedBox(height: 10),
            const Text(
              'Ala vermelha - Invertebrados Marinhos',
              style: TextStyle(
                color: mainBlue,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Estão expostos esqueletos calcários de grupos como poríferos e corais, localizados em frente aos aquários em que animais das mesmas espécies são apresentados vivos. As formas e cores dos moluscos são mostradas através de suas conchas e de espécimes como as lulas-gigantes conservadas inteiras. Os equinodermos são representados pelas estrelas, ouriços e pepinos do mar. A ala termina com a exposição de diversos crustáceos como camarões, siris, caranguejos, lagostas, entre outros.',
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 10),
            Image.asset(Assets.sections.red.path),
            // Green Section
            const SizedBox(height: 10),
            const Text(
              'Ala verde - Peixes cartilaginosos',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: mainBlue,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Nesta ala é apresentada uma grande variedade de tubarões e raias, com exemplares únicos, incluindo animais costeiros, oceânicos, de profundidade e ameaçados de extinção. São expostos dentes e maxilas das principais espécies deste grupo, incluindo a única maxila de tubarão branco em exposição no Brasil. Outro setor contempla as formas de reprodução deste grupo, revelando a grande adaptação a diferentes habitats marinhos. Também completam esta ala quatro aquários que representam os habitats destes animais na natureza.',
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 10),
            Image.asset(Assets.sections.green.path),
            // Brown Section
            const SizedBox(height: 10),
            const Text(
              'Ala marrom - Peixes ósseos',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: mainBlue,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Representantes das principais famílias de peixes ósseos estão expostos, mostrando a variedade de formas e adaptações do grupo. Destaque para grandes peixes como o primitivo e costeiro Tarpão e o oceânico espadarte. O plantel dos aquários é composto por peixes do Oceano Índico e do Oceano Pacífico. Completa esta ala uma raríssima exposição sobre os peixes de profundidade, que vivem na zona abissal, há mais de 2.000 metros de profundidade.',
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 10),
            Image.asset(Assets.sections.brown.path),
            // Gray Section
            const SizedBox(height: 10),
            const Text(
              'Ala cinza - Répteis marinhos',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: mainBlue,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Os répteis marinhos são restritos a apenas 14 espécies. A coleção do MOVI é majoritariamente composta por tartarugas marinhas. No Brasil ocorrem cinco espécies, todas apresentadas nesta ala. A exposição é a mais completa já montada e contempla vários aspectos da biologia e da ecologia desses animais, apresentando desde os pequenos filhotes até as tartatugas-marinhas-gigantes.',
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 10),
            Image.asset(Assets.sections.gray.path),
            // Beige Section
            const SizedBox(height: 10),
            const Text(
              'Ala Bege - Aves marinhas',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: mainBlue,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Esta ala destaca aspectos interessantes da biologia e ecologia de algumas espécies deste grupo. São apresentadas todas as espécies de pinguins, apontando sua distribuição no hemisfério Sul. O destaque fica por conta de um diorama representando uma ilha oceânica e que contém as espécies ameaçadas de extinção dos albatrozes errantes.',
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 10),
            Image.asset(Assets.sections.beige.path),
            // Black Section
            const SizedBox(height: 10),
            const Text(
              'Ala preta - Mamíferos marinhos',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: mainBlue,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'A exposição inicia com a parte histórica da caça à baleia e sua exploração comercial, atividade que foi muito praticada em Santa Catarina. Em seguida são expostas diversas espécies de golfinhos e baleias que ocorrem no sul do Brasil, apresentando aspectos da sua biologia. Também são contemplados os lobos e leões marinhos da América do Sul e os peixes-boi marinhos que ocorrem no nordeste brasileiro.',
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 10),
            Image.asset(Assets.sections.black.path),
            const SizedBox(height: 10),
            Image.asset(Assets.sections.black2.path),
          ],
        ),
      ),
    );
  }
}
