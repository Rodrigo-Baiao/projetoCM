// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class SupportFeedbackWidget extends StatefulWidget {
  const SupportFeedbackWidget({super.key});

  @override
  _SupportFeedbackWidgetState createState() => _SupportFeedbackWidgetState();
}

class _SupportFeedbackWidgetState extends State<SupportFeedbackWidget> {
  bool _showSupportText = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.contact_support_outlined),
            const SizedBox(width: 8),
            const Text('Support and feedback',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(width: 20),
            const Spacer(),
            GestureDetector(
              onTap: () {
                setState(() {
                  _showSupportText = !_showSupportText;
                });
              },
              child: Icon(_showSupportText ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up),
            ),
          ],
        ),
        if (_showSupportText)
          const Padding(padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text('É com grande apreço que saudamos sua presença em nossa plataforma. Reconhecemos a importância de fornecer um serviço excepcional e, como tal, estamos dedicados a garantir que sua experiência conosco seja nada menos que excelente.Nosso compromisso com a excelência se estende ao suporte e feedback que oferecemos. Entendemos que, em qualquer jornada digital, surgem dúvidas, preocupações e oportunidades de melhoria. Por isso, criamos uma equipe de suporte altamente capacitada e dedicada, pronta para responder prontamente às suas perguntas, resolver quaisquer problemas e ouvir atentamente suas sugestões.Nosso objetivo é construir uma comunidade onde cada voz seja ouvida e cada interação seja valorizada. Seja você um usuário iniciante que está se familiarizando com nosso aplicativo ou um veterano que busca aprimoramento contínuo, estamos aqui para oferecer orientação, suporte técnico e uma experiência personalizada.Ao enviar seu feedback, você não apenas nos ajuda a aprimorar nossos serviços, mas também contribui para a evolução da plataforma, tornando-a mais útil, eficiente e gratificante para todos os usuários.Portanto, não hesite em entrar em contato conosco a qualquer momento. Seja por meio do nosso sistema de suporte integrado, e-mail dedicado ou mesmo pelas redes sociais, estamos sempre disponíveis para ouvir suas opiniões, responder suas perguntas e resolver seus problemas.Agradecemos profundamente sua confiança em nossa plataforma e estamos comprometidos em superar suas expectativas em todos os aspectos.', // Texto de suporte e feedback
              style: TextStyle(fontSize: 12),
            ),
          ),
      ],
    );
  }
}
