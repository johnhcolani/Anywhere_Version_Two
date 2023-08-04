import 'package:anywhere_variant_two/features/wireviewer_fearture/presentation_layer/screens/web_view.dart';
import 'package:flutter/material.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/strings_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../data_layer/models/wireviewer_model.dart';

class DetailScreen extends StatelessWidget {
  final WireViewerCharacter character;

  const DetailScreen({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    double he = MediaQuery.of(context).size.height;
    double wi = MediaQuery.of(context).size.width;

    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: ColorManager.darkBlue,
        height: he*0.05,
      ) ,
      backgroundColor: ColorManager.darkGrey,
      appBar: AppBar(
        backgroundColor: ColorManager.darkBlue,
        title: Center(child: Text(character.name)),
      ),
      body: Padding(
        padding:  EdgeInsets.all(wi * 0.05),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: he * 0.03),
                child: Text(
                  character.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ColorManager.yellow,
                    fontSize: AppSize.s25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: he * 0.03),
                width: wi * 0.5,
                height: wi * 0.5,
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/place.png',
                  image: character.imageUrl,
                  fit: BoxFit.contain,
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Image.asset('assets/images/place.png');
                  },
                ),
              ),
              SizedBox(height: he * 0.05),
              Text(
                character.text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ColorManager.white,
                  fontSize: AppSize.s20,
                ),
              ),
              if (character.firstUrl.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(top: he * 0.1),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WebViewAppStack(
                              characterName: character.name,
                              character: character,
                            ),
                          ));
                    },
                    child: Text(
                      AppStrings.openInWeb,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: ColorManager.yellow,
                        fontSize: AppPadding.p20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
