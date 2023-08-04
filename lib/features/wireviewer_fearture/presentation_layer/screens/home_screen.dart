import 'package:flutter/material.dart';
import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/strings_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../data_layer/models/wireviewer_model.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  final List<WireViewerCharacter> characters;

  const HomeScreen({super.key, required this.characters});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<WireViewerCharacter> filteredCharacters = [];
  bool isLoading = true;
  bool isSearchEmpty = true;

  @override
  void initState() {
    super.initState();
    _loadCharacters();
  }

  void _loadCharacters() {
    Future.delayed( const Duration(seconds: DurationConstant.d2), () {
      setState(() {
        filteredCharacters = widget.characters;
        isLoading = false;
      });
    });
  }

  void _filterCharacters(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredCharacters = widget.characters;
      } else {
        filteredCharacters = widget.characters
            .where((character) =>
                character.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double he = MediaQuery.of(context).size.height;
    double wi = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ColorManager.darkGrey,
      appBar: AppBar(
        backgroundColor: ColorManager.darkBlue,
        automaticallyImplyLeading: false,
        title: const Center(child: Text(AppStrings.wireViewerCharacter)),
      ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                vertical: wi * 0.05, horizontal: wi * 0.05),
            child: TextField(
              controller: _searchController,
              onChanged: (query) {
                _filterCharacters(query);
                setState(() {
                  isSearchEmpty = query.length == LengthConstant.l0;
                });
              },
              style: TextStyle(color: ColorManager.white),
              decoration: InputDecoration(
                hintText: AppStrings.hintText,
                labelText: AppStrings.labelText,
                labelStyle: TextStyle(color: ColorManager.grey1),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color:
                          ColorManager.grey1), // Set enabled border color here
                  borderRadius: BorderRadius.circular(AppSize.s20),
                ),
                prefixIcon: isSearchEmpty
                    ? Icon(
                        Icons.search,
                        color: ColorManager.grey1,
                      )
                    : IconButton(
                        onPressed: () {
                          _searchController.clear();
                          _filterCharacters('');
                          setState(() {
                            isSearchEmpty = true;
                          });
                        },
                        icon: Icon(Icons.clear, color: ColorManager.grey1)),
                hintStyle: TextStyle(color: ColorManager.grey1),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: ColorManager.yellow, width: 4),
                  borderRadius: BorderRadius.circular(AppSize.s25),
                ),
              ),
            ),
          ),
          if (isLoading)
            Center(
              child: CircularProgressIndicator(
                color: ColorManager.yellow,
              ),
            ),
          if (!isLoading)
            Padding(
              padding: EdgeInsets.only(top: he * 0.09),
              child: ListView.builder(
                itemCount: filteredCharacters.length,
                itemBuilder: (context, index) {
                  final character = filteredCharacters[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(
                            character: character,
                          ),
                        ),
                      );
                    },
                    child: CharacterListItem(character: character),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

class CharacterListItem extends StatelessWidget {
  final WireViewerCharacter character;

  const CharacterListItem({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    double he = MediaQuery.of(context).size.height;
    double wi = MediaQuery.of(context).size.width;
    return Padding(
      padding:  EdgeInsets.symmetric( vertical: he*0.002,horizontal:wi*0.05),
      child: Card(

        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: wi*0.002,
            color: ColorManager.whiteGreen,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s16)),
        ),
        color: ColorManager.grey2,
        child: ListTile(
          leading: SizedBox(
            width: wi*0.2,
            height: he*0.3,
            child: FadeInImage.assetNetwork(
              placeholder: ImageAssets.placeHolderImage,
              image: character.imageUrl,
              fit: BoxFit.contain,
              imageErrorBuilder: (context, error, stackTrace) {
                return Image.asset(ImageAssets.placeHolderImage);
              },
            ),
          ),
          title: Column(
            children: [
              Text(
                character.name,
                style: TextStyle(color: ColorManager.yellow, fontSize: AppSize.s25),
              ),
            ],
          ),
          subtitle: Text(
            character.text,
            style: TextStyle(color: ColorManager.white, fontSize: AppSize.s16),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailScreen(
                  character: character,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
