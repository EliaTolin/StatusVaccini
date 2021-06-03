import 'package:flutter/material.dart';
import 'package:statusvaccini/Models/opendata.dart';
import 'package:statusvaccini/Screens/components/pageitems/region_details_items.dart';
import 'package:statusvaccini/Screens/components/body_components.dart';

class RegionDetailsView extends StatelessWidget {
  RegionDetailsView(this.regione);
  final Regione regione;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: TopBarRegioni(size, title: "${regione.nome}"),
      body: FutureBuilder(
          future: OpenData.getDatiRegioniGiornoPerGiorno(regione.sigla),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(child: CircularProgressIndicator());
            return SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (final regionDetailsItem
                          in RegionDetailsItems.getItems(
                              regione, snapshot.data))
                        regionDetailsItem.card
                    ],
                  )),
            );
          }),
    );
  }
}
