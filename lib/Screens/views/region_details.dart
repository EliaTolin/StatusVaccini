import 'package:flutter/material.dart';
import 'package:statusvaccini/Models/opendata.dart';
import 'package:statusvaccini/Screens/components/pageitems/region_details_items.dart';

class RegionDetailsView extends StatelessWidget {
  RegionDetailsView(this.regione);

  final Regione regione;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Dettagli regione ${regione.nome}",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0.0,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder(
          future: OpenData.getDatiRegioniGiornoPerGiorno(regione.sigla),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(child: CircularProgressIndicator());
            return SingleChildScrollView(
                child: Column(
              children: [
                for (final regionDetailsItem
                    in RegionDetailsItems.getItems(regione, snapshot.data))
                  regionDetailsItem.card
              ],
            ));
          }),
    );
  }
}
