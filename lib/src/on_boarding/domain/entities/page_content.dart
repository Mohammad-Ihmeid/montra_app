import 'package:equatable/equatable.dart';
import 'package:montra_app/core/res/media_res.dart';

class PageContent extends Equatable {
  const PageContent({
    required this.image,
    required this.title,
    required this.description,
  });

  const PageContent.first()
      : this(
          image: MediaRes.controlYourMoney,
          title: 'Gain total control of your money',
          description:
              'Become your own money manager and make every cent count',
        );

  const PageContent.second()
      : this(
          image: MediaRes.whereYourMoney,
          title: 'Know where your money goes',
          description: 'Track your transaction easily, with categories '
              'and financial report',
        );

  const PageContent.third()
      : this(
          image: MediaRes.planningAhead,
          title: 'Planning ahead',
          description: 'Setup your budget for each category so you in control',
        );

  final String image;
  final String title;
  final String description;

  @override
  List<Object> get props => [image, title, description];
}
