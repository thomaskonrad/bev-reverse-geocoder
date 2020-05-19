-- Delete addresses with no house number.
DELETE FROM bev_addresses WHERE house_number = '';

-- Mark addresses that have an associated locality in the BEV database as type "place".
UPDATE bev_addresses SET address_type='place'  WHERE street IN (SELECT DISTINCT(locality) FROM bev_addresses);

-- Correct addresses which are marked as "street" type but are of type "place".
UPDATE bev_addresses SET address_type = 'street'
--SELECT municipality, street, count(house_number) FROM bev_addresses
WHERE
  (
	  -- Municipalities that don't have any localities but only street names.
		municipality IN (
		  'Wien', 'Dornbirn', 'Eisenstadt', 'Gerasdorf bei Wien', 'Fraxern', 'Höchst', 'Horn', 'Innsbruck',
		  'Klagenfurt am Wörthersee', 'Lustenau', 'Kapfenberg', 'Karlstein an der Thaya', 'Klaus', 'Klosterneuburg',
		  'Koblach', 'Korneuburg', 'Landeck', 'Langen bei Bregenz', 'Langenrohr', 'Leithaprodersdorf', 'Lienz', 'Liezen',
		  'Linz', 'Ludesch', 'Neulengbach', 'Neusiedl am See', 'Oberhofen im Inntal', 'Passail', 'Peggau', 'Pinkafeld',
		  'Pitten', 'Podersdorf am See', 'Poggersdorf', 'Polling in Tirol', 'Pottendorf', 'Puchenau',
		  'Purbach am Neusiedler See', 'Purkersdorf', 'Pörtschach am Wörther See', 'Rankweil', 'Ried im Innkreis', 'Rust',
		  'Röthis', 'Salzburg', 'Sautens', 'Schladming', 'Schlins', 'Schärding', 'St. Pölten', 'Stockerau', 'Straßwalchen',
		  'Teesdorf', 'Traunkirchen', 'Trieben', 'Tulln an der Donau', 'Uderns', 'Umhausen', 'Unterach am Attersee',
		  'Uttendorf', 'Baden', 'Vöcklabruck', 'Villach', 'Vils', 'Wagna', 'Wildschönau', 'Winzendorf-Muthmannsdorf',
		  'Wolfsegg am Hausruck', 'Wolfurt', 'Wolkersdorf im Weinviertel', 'Wulkaprodersdorf', 'Wöllersdorf-Steinabrückl',
		  'Wörgl', 'Würmla', 'Ybbs an der Donau', 'Ybbsitz', 'Zams', 'Zeiselmauer-Wolfpassing', 'Zelking-Matzleinsdorf',
		  'Zell am Moos', 'Zell am See', 'Zell am Ziller', 'Zell an der Pram', 'Zeltweg', 'Zillingdorf', 'Zistersdorf',
		  'Zurndorf', 'Zwentendorf an der Donau', 'Zwettl an der Rodl', 'Zwischenwasser', 'Zwölfaxing', 'Öblarn',
		  'Übelbach', 'Übersaxen', 'Wals-Siezenheim', 'Weiden am See', 'Weiler', 'Weißenbach am Lech',
		  'Weißenkirchen in der Wachau', 'Wels', 'Wiener Neudorf', 'Wiener Neustadt', 'Wieselburg', 'Winden am See'
		)
 
    -- Common patterns for street names in Austria.
    OR LOWER(street) LIKE '%straße'
		OR LOWER(street) LIKE '%straße %'
		OR LOWER(street) LIKE '%strasse'
		OR LOWER(street) LIKE '%strasse %'
		OR LOWER(street) LIKE '%sträßle'
		OR LOWER(street) LIKE '%sträßle %'
		OR LOWER(street) LIKE '%str.'
		OR LOWER(street) LIKE '%str. %'
		OR LOWER(street) LIKE '%gasse'
		OR LOWER(street) LIKE '%gasse %'
		OR LOWER(street) LIKE '%gasserl'
		OR LOWER(street) LIKE '%gasserl %'
		OR LOWER(street) LIKE '%gässele'
		OR LOWER(street) LIKE '%gässele %'
		OR LOWER(street) LIKE '%gässle'
		OR LOWER(street) LIKE '%gässli'
		OR LOWER(street) LIKE '%gässli %'
		OR LOWER(street) LIKE '%gassl'
		OR LOWER(street) LIKE '%gassl %'
		OR LOWER(street) LIKE '%gäßchen'
		OR LOWER(street) LIKE '%gäßchen %'
		OR LOWER(street) LIKE '%gaßl'
		OR LOWER(street) LIKE '%gaßl %'
		OR LOWER(street) LIKE '%weg'
		OR LOWER(street) LIKE '%weg %'
		OR LOWER(street) LIKE '%ring'
		OR LOWER(street) LIKE '%ring %'
		OR LOWER(street) LIKE '%-ring'
		OR LOWER(street) LIKE '%-ring %'
		OR LOWER(street) LIKE '% ring'
		OR LOWER(street) LIKE '% ring %'
		OR LOWER(street) LIKE '%gürtel'
		OR LOWER(street) LIKE '%gürtel %'
		OR LOWER(street) LIKE '%promenade'
		OR LOWER(street) LIKE '%promenade %'
		OR LOWER(street) LIKE '%kai'
		OR LOWER(street) LIKE '%kai %'
		OR LOWER(street) LIKE '%allee'
		OR LOWER(street) LIKE '%allee %'
		OR LOWER(street) LIKE '%park'
		OR LOWER(street) LIKE '%park %'
		OR LOWER(street) LIKE '%lände'
		OR LOWER(street) LIKE '%lände %'
		OR LOWER(street) LIKE '%passage'
		OR LOWER(street) LIKE '%passage %'
		OR LOWER(street) LIKE '%brücke'
		OR LOWER(street) LIKE '%brücke %'
		OR LOWER(street) LIKE '%siedlung'
		OR LOWER(street) LIKE '%siedlung %'
		OR LOWER(street) LIKE '%platz'
		OR LOWER(street) LIKE '%platz %'
		OR LOWER(street) LIKE '%platzl'
		OR LOWER(street) LIKE '%platzl %'
		OR LOWER(street) LIKE '%tunnel'
		OR LOWER(street) LIKE '%tunnel %'
		OR LOWER(street) LIKE '%blick'
		OR LOWER(street) LIKE '%blick %'
		OR LOWER(street) LIKE '%bühel'
		OR LOWER(street) LIKE '%bühel %'
		OR LOWER(street) LIKE '%wies'
		OR LOWER(street) LIKE '%wies %'
		OR LOWER(street) LIKE '%wiese'
		OR LOWER(street) LIKE '%wiese %'
		OR LOWER(street) LIKE '%steig'
		OR LOWER(street) LIKE '%steig %'
		OR LOWER(street) LIKE '%steg'
		OR LOWER(street) LIKE '%steg %'
		OR LOWER(street) LIKE '%lehen'
		OR LOWER(street) LIKE '%lehen %'
		OR LOWER(street) LIKE '%mahd'
		OR LOWER(street) LIKE '%mahd %'
		OR LOWER(street) LIKE '%rain'
		OR LOWER(street) LIKE '%rain %'
		OR LOWER(street) LIKE '%anger'
		OR LOWER(street) LIKE '%anger %'
		OR LOWER(street) LIKE '%zeile'
		OR LOWER(street) LIKE '%zeile %'
		OR LOWER(street) LIKE '%ried'
		OR LOWER(street) LIKE '%ried %'
		OR LOWER(street) LIKE '%winkel'
		OR LOWER(street) LIKE '%winkel %'
		OR LOWER(street) LIKE '%winkl'
		OR LOWER(street) LIKE '%winkl %'
		OR LOWER(street) LIKE '%breite'
		OR LOWER(street) LIKE '%breite %'
		OR LOWER(street) LIKE '%hang'
		OR LOWER(street) LIKE '%hang %'
		OR LOWER(street) LIKE '%grund'
		OR LOWER(street) LIKE '%grund %'
		OR LOWER(street) LIKE '%leite'
		OR LOWER(street) LIKE '%leite %'
		OR LOWER(street) LIKE '%leiten'
		OR LOWER(street) LIKE '%leiten %'
		OR LOWER(street) LIKE '%leithen'
		OR LOWER(street) LIKE '%leithen %'
		OR LOWER(street) LIKE '%stiege'
		OR LOWER(street) LIKE '%stiege %'
		OR LOWER(street) LIKE '%stätte'
		OR LOWER(street) LIKE '%stätte %'
		OR LOWER(street) LIKE '% au'
		OR LOWER(street) LIKE '% au %'
		OR LOWER(street) LIKE 'bei d%'
		OR LOWER(street) LIKE 'beim %'
		OR LOWER(street) LIKE 'am %'
		OR LOWER(street) LIKE 'an %'
		OR LOWER(street) LIKE 'auf d%'
		OR LOWER(street) LIKE 'im %'
		OR LOWER(street) LIKE 'in %'
		OR LOWER(street) LIKE 'unter d%'
		OR LOWER(street) LIKE 'zu %'
		OR LOWER(street) LIKE 'zum %'
		OR LOWER(street) LIKE 'zur %'
		OR LOWER(street) LIKE 'untere %'
		OR LOWER(street) LIKE 'unterer %'
		OR LOWER(street) LIKE 'unteres %'
		OR LOWER(street) LIKE 'unterm %'
		OR LOWER(street) LIKE 'obere %'
		OR LOWER(street) LIKE 'oberer %'
		OR LOWER(street) LIKE 'oberes %'
		OR LOWER(street) LIKE 'hinter d%'
		OR LOWER(street) LIKE 'ob d%'
		OR LOWER(street) LIKE 'vorm %'
		OR LOWER(street) LIKE 'hinter %'

		-- Special street names that are not recognizable as streets as such just by their name.
		-- Please submit a pull request if you know more examples!
		-- This is especially common in Vorarlberg (see Andelsbuch, for example).
		OR street IN (
		  'Bofel', 'Buxera', 'Gugger Nussbaum', 'Schufla', 'Bola', 'Breite', 'Alberau', 'Gehren', 'Grünegger', 'Binsenfeld',
		  'Blumenau', 'Auf Litschis', 'Polder', 'Bungat', 'Riedle', 'Herrenfeld', 'Riedgarten', 'Liebera', 'Mühlwasen',
		  'Garazerfeld', 'Hasenau', 'Gässli', 'Neugebäude', 'Melans', 'Ranser Feld', 'Winkelgarten', 'Winklfeld', 'Itter',
		  'Grund', 'Grunholz', 'Wirth', 'Ach', 'Ruhmanen', 'Gaß', 'Scheidbuchen', 'Fahl', 'Buchen', 'Hüngen', 'Loch',
		  'Heidegg', 'Bauern', 'Amtsschmiedhöhe', 'Föhrenwald', 'Frauental', 'Fröschlpoint', 'Marienpark',
		  'Graben Amstetten', 'Graben Ulmerfeld', 'Platte', 'Daliebis', 'Bazol', 'Haslat', 'Schüttenacker',
		  'Graf-Rudolf-Wuhrgang', 'Graf-Hugo-Wuhrgang', 'Churer Tor', 'Gempala', 'Motta', 'Gosta', 'Troja', 'Untere Gosta',
		  'Obere Gosta', 'Kilknerwald', 'Bonawinkel', 'Inner Tobel', 'Sprisaloch', 'Zerfall', 'Boda', 'Güatli', 'Floßländ',
		  'Quellenhof', 'Hoher Markt', 'Walchsee', 'Walchsee', 'Ringmauer', 'Conrad-Lester-Hof', 'Großmühlhäuser', 'Lötz'
		)
	)
	AND
	(
    -- Places that end with "ring" but are not streets for sure.
    street NOT IN (
      'Badhöring', 'Biedring', 'Daring', 'Dobring', 'Ebring', 'Ehring', 'Engljähring', 'Euring',
      'Evangelischer Friedhof Simmering', 'Feistring', 'Felbring', 'Feuerhalle Simmering', 'Feuring', 'Fischering',
      'Fischhamering', 'Födering', 'Gadering', 'Gattring', 'Geigering', 'Gemering', 'Giering', 'Gimpering',
      'Ginshöring', 'Gunsering', 'Guttaring', 'Gössering', 'Habring', 'Hallenbad Simmering', 'Haudering', 'hiering',
      'Hilkering', 'Hintering', 'Hintring', 'Höring', 'Ingering II', 'Innernöring', 'Jauring', 'Kaffring', 'Kellnering',
      'Kleinsemmering', 'Kring', 'Köfering', 'Kühnring', 'Liedering', 'Littring', 'Mahring', 'Mairing', 'Marchtring',
      'Marchtring', 'Mittergafring', 'Mähring', 'Mödring', 'Mühring', 'Niederbairing', 'Oberbairing', 'Obergafring',
      'Oberjahring', 'Oberkansering', 'Oberring', 'Oberrühring', 'Oberschöfring', 'Ochsenharing', 'Olsaring', 'Pehring',
      'Pengering', 'Pesenlittring', 'Pöbring', 'Pühring', 'Rackering', 'Ragering', 'Reichering', 'Reitering', 'Rubring',
      'Rühring', 'Schillering', 'Schnittering', 'Schoppering', 'Seiring', 'Semering', 'Semmering', 'Seyring',
      'Silbering', 'Sindhöring', 'Stamering', 'Steiring', 'Unering', 'Unterkansering', 'Unterpassering', 'Uring',
      'Vordernöring', 'Wahring', 'Waidring', 'Walkering', 'Wassering', 'Wienering', 'Wolfring', 'Wöbring', 'Wögring',
      'Wölzing-Fischering', 'Zintring', 'Zwaring', 'Zwischensimmering', 'Zöbring',

      -- Places that end with "rain" but are not streets for sure.
      'Halbenrain', 'Achrain', 'Draurein', 'Harrain', 'Hochrain', 'Hungerrain', 'Hungerrain', 'Niedermauern-Rain',
      'Podrain', 'Rotrain', 'Sellrain', 'Silberrain', 'Unterkrain', 'Wagrain',

      -- Places that end with "ried" but are not streets for sure.
      'Ritzenried',

      -- Places that end with "winkl" or "winkel" but are not streets for sure.
      'Auwinkl',

      -- Places that end with "hang" but are not streets for sure.
      'Anhang',

      -- Places that end with "grund" but are not streets for sure.
      'Schöngrund', 'Zemmgrund', 'Zillergrund', 'Höllgrund',

      -- Places that end with "leite", leiten" or "leithen" but are not streets for sure.
      'Kohlleiten', 'Hundertleiten', 'Loderleiten',

      -- Places that end with "steg" but are not streets for sure.
      'Hochsteg', 'Hohensteg',

      -- Places where the whole municipality is supposed to have only streets and not localities, with the following exceptions.
      'Madau'

      -- Not sure with these.
      -- 'Bergfried'
		)
	)
--GROUP BY municipality, street ORDER BY municipality
;



-- Remove " ,alle [geraden|ungeraden] Zahlen[ des Intervalls]" strings from the house numbers.
UPDATE bev_addresses SET house_number=split_part(house_number, ', alle', 1)
  WHERE house_number LIKE '%alle geraden%'
  OR house_number LIKE '%alle ungeraden%';



-- Remove the place name at the end of each "Bahnstraße" in the municipality of Ebreichsdorf.
UPDATE bev_addresses SET street = 'Bahnstraße' WHERE municipality = 'Ebreichsdorf' AND street LIKE 'Bahnstraße %';


-- In Wildschönau, streets are depicted as "street, locality". We delete the part after the comma because the locality
-- can be found in the "locality" column anyway.
UPDATE bev_addresses SET street=split_part(street, ', ', 1)
  WHERE municipality = 'Wildschönau';

-- Some bigger cities have their own districts, and those are set as the locality in the BEV data set. However, in
-- OpenStreetMap, the addr:city tag in Vienna, Graz, Innsbruck, and Klagenfurt am Wörtersee, etc. are set to the name of
-- the city, not the district. Some other cities like Leonding and Klosterneuburg have smaller localities around the
-- city, but even there the city name is taken for addr:city.
/* UPDATE bev_addresses SET locality = municipality
  WHERE municipality IN (
    'Wien', 'Graz', 'Innsbruck', 'Klagenfurt am Wörthersee', 'Villach', 'Wels', 'Bregenz', 'Leonding', 'Klosterneuburg',
    'Leoben', 'Krems an der Donau', 'Traun', 'Kapfenberg', 'Hallein', 'Kufstein', 'Braunau am Inn'
  )
  -- There are some exceptions, for example, Ranshofen in the municipality of Braunau am Inn is mostly mentioned as the
  -- city in addresses instead of the municipality name "Braunau am Inn".
  AND locality NOT IN (
    'Ranshofen'
  );*/

-- Set the column "municipality_has_ambiguous_addresses" to TRUE for addresses in municipalities that have ambiguous
-- addresses. This happens if one municipality has a specific combination of postcode and street distributed over
-- multiple localities (see Amstetten, for example). This is important because then, we need to set the "addr:city" tag
-- to the value of the locality and not the municipality so that the address is unique.
UPDATE bev_addresses
SET municipality_has_ambiguous_addresses = TRUE
WHERE municipality IN (
  SELECT municipality FROM (
    SELECT DISTINCT
      municipality,
      string_agg(locality, ', ' ORDER BY locality) AS localities,
      postcode,
      street,
      COUNT(DISTINCT(locality))
    FROM
      bev_addresses
    GROUP BY
      municipality,
      postcode,
      street,
      house_number
    HAVING
      COUNT(DISTINCT(locality)) > 1
  ) as non_unique_addresses
);

-- Clean up the locality strings of the cities of Vienna, Graz, and Klagenfurt
UPDATE bev_addresses SET locality = split_part(locality, ',', 2)
  WHERE municipality = 'Wien';

UPDATE bev_addresses SET locality = split_part(locality, ':', 2)
  WHERE municipality = 'Graz';

UPDATE bev_addresses SET locality = split_part(locality, ':', 2)
  WHERE municipality = 'Klagenfurt am Wörthersee';

-- This one is abbreviated in the BEV dataset.
UPDATE bev_addresses SET locality = 'Völkermarkter Vorstadt'
  WHERE locality = 'Völkermarkt.Vorst.';

-- In Carinthia's municipality of Frauenstein, most streets are named like "<hamlet>/<street>". The following
-- statement corrects this to simply "<street>".
UPDATE bev_addresses SET street=split_part(street, '/', 2) WHERE municipality='Frauenstein' and street like '%/%';

-- In the same municipality, there are streets that end with "-W.". The followin statement corrects this to "-Weg".
UPDATE bev_addresses SET street=replace(street, '-W.', '-Weg') WHERE municipality='Frauenstein' AND street LIKE '%-W.';
