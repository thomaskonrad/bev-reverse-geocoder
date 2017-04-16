-- Correct addresses which are marked as "street" type but are of type "place".
UPDATE bev_addresses SET address_type = 'place'
--SELECT municipality, street, count(house_number) FROM bev_addresses
WHERE address_type = 'street'
  AND
	  -- Municipalities that don't have any localities but only street names.
		municipality NOT IN ('Wien', 'Dornbirn', 'Eisenstadt', 'Gerasdorf bei Wien', 'Fraxern', 'Höchst', 'Horn', 'Innsbruck', 'Klagenfurt am Wörthersee', 'Lustenau', 'Kapfenberg', 'Karlstein an der Thaya', 'Klaus', 'Klosterneuburg', 'Koblach', 'Korneuburg', 'Landeck', 'Langen bei Bregenz', 'Langenrohr', 'Leithaprodersdorf', 'Lienz', 'Liezen', 'Linz', 'Ludesch', 'Neulengbach', 'Neusiedl am See', 'Oberhofen im Inntal', 'Passail', 'Peggau', 'Pinkafeld', 'Pitten', 'Podersdorf am See', 'Poggersdorf', 'Polling in Tirol', 'Pottendorf', 'Puchenau', 'Purbach am Neusiedler See', 'Purkersdorf', 'Pörtschach am Wörther See', 'Rankweil', 'Ried im Innkreis', 'Rust', 'Röthis', 'Salzburg', 'Sautens', 'Schladming', 'Schlins', 'Schärding', 'St. Pölten', 'Stockerau', 'Straßwalchen', 'Teesdorf', 'Traunkirchen', 'Trieben', 'Tulln an der Donau', 'Uderns', 'Umhausen', 'Unterach am Attersee', 'Uttendorf', 'Baden', 'Vöcklabruck', 'Villach', 'Vils', 'Wagna', 'Wildschönau', 'Winzendorf-Muthmannsdorf', 'Wolfsegg am Hausruck', 'Wolfurt', 'Wolkersdorf im Weinviertel', 'Wulkaprodersdorf', 'Wöllersdorf-Steinabrückl', 'Wörgl', 'Würmla', 'Ybbs an der Donau', 'Ybbsitz', 'Zams', 'Zeiselmauer-Wolfpassing', 'Zelking-Matzleinsdorf', 'Zell am Moos', 'Zell am See', 'Zell am Ziller', 'Zell an der Pram', 'Zeltweg', 'Zillingdorf', 'Zistersdorf', 'Zurndorf', 'Zwentendorf an der Donau', 'Zwettl an der Rodl', 'Zwischenwasser', 'Zwölfaxing', 'Öblarn', 'Übelbach', 'Übersaxen')
	AND
	(
		(
			-- Common patterns for street names in Austria.
			LOWER(street) NOT LIKE '%straße'
			AND LOWER(street) NOT LIKE '%straße %'
			AND LOWER(street) NOT LIKE '%strasse'
			AND LOWER(street) NOT LIKE '%strasse %'
			AND LOWER(street) NOT LIKE '%sträßle'
			AND LOWER(street) NOT LIKE '%sträßle %'
			AND LOWER(street) NOT LIKE '%str.'
			AND LOWER(street) NOT LIKE '%str. %'
			AND LOWER(street) NOT LIKE '%gasse'
			AND LOWER(street) NOT LIKE '%gasse %'
			AND LOWER(street) NOT LIKE '%gasserl'
			AND LOWER(street) NOT LIKE '%gasserl %'
			AND LOWER(street) NOT LIKE '%gässele'
			AND LOWER(street) NOT LIKE '%gässele %'
			AND LOWER(street) NOT LIKE '%gässle'
			AND LOWER(street) NOT LIKE '%gässli'
			AND LOWER(street) NOT LIKE '%gässli %'
			AND LOWER(street) NOT LIKE '%gassl'
			AND LOWER(street) NOT LIKE '%gassl %'
			AND LOWER(street) NOT LIKE '%gäßchen'
			AND LOWER(street) NOT LIKE '%gäßchen %'
			AND LOWER(street) NOT LIKE '%gaßl'
			AND LOWER(street) NOT LIKE '%gaßl %'
			AND LOWER(street) NOT LIKE '%weg'
			AND LOWER(street) NOT LIKE '%weg %'
			AND LOWER(street) NOT LIKE '%ring'
			AND LOWER(street) NOT LIKE '%ring %'
			AND LOWER(street) NOT LIKE '%-ring'
			AND LOWER(street) NOT LIKE '%-ring %'
			AND LOWER(street) NOT LIKE '% ring'
			AND LOWER(street) NOT LIKE '% ring %'
			AND LOWER(street) NOT LIKE '%gürtel'
			AND LOWER(street) NOT LIKE '%gürtel %'
			AND LOWER(street) NOT LIKE '%promenade'
			AND LOWER(street) NOT LIKE '%promenade %'
			AND LOWER(street) NOT LIKE '%kai'
			AND LOWER(street) NOT LIKE '%kai %'
			AND LOWER(street) NOT LIKE '%allee'
			AND LOWER(street) NOT LIKE '%allee %'
			AND LOWER(street) NOT LIKE '%park'
			AND LOWER(street) NOT LIKE '%park %'
			AND LOWER(street) NOT LIKE '%lände'
			AND LOWER(street) NOT LIKE '%lände %'
			AND LOWER(street) NOT LIKE '%passage'
			AND LOWER(street) NOT LIKE '%passage %'
			AND LOWER(street) NOT LIKE '%brücke'
			AND LOWER(street) NOT LIKE '%brücke %'
			AND LOWER(street) NOT LIKE '%siedlung'
			AND LOWER(street) NOT LIKE '%siedlung %'
			AND LOWER(street) NOT LIKE '%platz'
			AND LOWER(street) NOT LIKE '%platz %'
			AND LOWER(street) NOT LIKE '%platzl'
			AND LOWER(street) NOT LIKE '%platzl %'
			AND LOWER(street) NOT LIKE '%tunnel'
			AND LOWER(street) NOT LIKE '%tunnel %'
			AND LOWER(street) NOT LIKE '%blick'
			AND LOWER(street) NOT LIKE '%blick %'
			AND LOWER(street) NOT LIKE '%bühel'
			AND LOWER(street) NOT LIKE '%bühel %'
			AND LOWER(street) NOT LIKE '%wies'
			AND LOWER(street) NOT LIKE '%wies %'
			AND LOWER(street) NOT LIKE '%wiese'
			AND LOWER(street) NOT LIKE '%wiese %'
			AND LOWER(street) NOT LIKE '%steig'
			AND LOWER(street) NOT LIKE '%steig %'
			AND LOWER(street) NOT LIKE '%steg'
			AND LOWER(street) NOT LIKE '%steg %'
			AND LOWER(street) NOT LIKE '%lehen'
			AND LOWER(street) NOT LIKE '%lehen %'
			AND LOWER(street) NOT LIKE '%mahd'
			AND LOWER(street) NOT LIKE '%mahd %'
			AND LOWER(street) NOT LIKE '%rain'
			AND LOWER(street) NOT LIKE '%rain %'
			AND LOWER(street) NOT LIKE '%anger'
			AND LOWER(street) NOT LIKE '%anger %'
			AND LOWER(street) NOT LIKE '%zeile'
			AND LOWER(street) NOT LIKE '%zeile %'
			AND LOWER(street) NOT LIKE '%ried'
			AND LOWER(street) NOT LIKE '%ried %'
			AND LOWER(street) NOT LIKE '%winkel'
			AND LOWER(street) NOT LIKE '%winkel %'
			AND LOWER(street) NOT LIKE '%winkl'
			AND LOWER(street) NOT LIKE '%winkl %'
			AND LOWER(street) NOT LIKE '%breite'
			AND LOWER(street) NOT LIKE '%breite %'
			AND LOWER(street) NOT LIKE '%hang'
			AND LOWER(street) NOT LIKE '%hang %'
			AND LOWER(street) NOT LIKE '%grund'
			AND LOWER(street) NOT LIKE '%grund %'
			AND LOWER(street) NOT LIKE '%leite'
			AND LOWER(street) NOT LIKE '%leite %'
			AND LOWER(street) NOT LIKE '%leiten'
			AND LOWER(street) NOT LIKE '%leiten %'
			AND LOWER(street) NOT LIKE '%leithen'
			AND LOWER(street) NOT LIKE '%leithen %'
			AND LOWER(street) NOT LIKE '%stiege'
			AND LOWER(street) NOT LIKE '%stiege %'
			AND LOWER(street) NOT LIKE '%stätte'
			AND LOWER(street) NOT LIKE '%stätte %'
			AND LOWER(street) NOT LIKE '% au'
			AND LOWER(street) NOT LIKE '% au %'
			AND LOWER(street) NOT LIKE 'bei d%'
			AND LOWER(street) NOT LIKE 'beim %'
			AND LOWER(street) NOT LIKE 'am %'
			AND LOWER(street) NOT LIKE 'an %'
			AND LOWER(street) NOT LIKE 'auf d%'
			AND LOWER(street) NOT LIKE 'im %'
			AND LOWER(street) NOT LIKE 'in %'
			AND LOWER(street) NOT LIKE 'unter d%'
			AND LOWER(street) NOT LIKE 'zu %'
			AND LOWER(street) NOT LIKE 'zum %'
			AND LOWER(street) NOT LIKE 'zur %'
			AND LOWER(street) NOT LIKE 'untere %'
			AND LOWER(street) NOT LIKE 'unterer %'
			AND LOWER(street) NOT LIKE 'unteres %'
			AND LOWER(street) NOT LIKE 'unterm %'
			AND LOWER(street) NOT LIKE 'obere %'
			AND LOWER(street) NOT LIKE 'oberer %'
			AND LOWER(street) NOT LIKE 'oberes %'
			AND LOWER(street) NOT LIKE 'hinter d%'
			AND LOWER(street) NOT LIKE 'ob d%'
			AND LOWER(street) NOT LIKE 'vorm %'
			AND LOWER(street) NOT LIKE 'hinter %'

			-- Special street names that are not recognizable as streets as such just by their name.
			-- Please submit a pull request if you know more examples!
			-- This is especially common in Vorarlberg (see Andelsbuch, for example).
			AND street NOT IN ('Bofel', 'Buxera', 'Gugger Nussbaum', 'Schufla', 'Bola', 'Breite', 'Alberau', 'Gehren', 'Grünegger', 'Binsenfeld', 'Blumenau', 'Auf Litschis', 'Polder', 'Bungat', 'Riedle', 'Herrenfeld', 'Riedgarten', 'Liebera', 'Mühlwasen', 'Garazerfeld', 'Hasenau', 'Gässli', 'Neugebäude', 'Melans', 'Ranser Feld', 'Winkelgarten', 'Winklfeld', 'Itter', 'Grund', 'Grunholz', 'Wirth', 'Ach', 'Ruhmanen', 'Gaß', 'Scheidbuchen', 'Fahl', 'Buchen', 'Hüngen', 'Loch', 'Heidegg', 'Bauern', 'Amtsschmiedhöhe', 'Föhrenwald', 'Frauental', 'Fröschlpoint', 'Marienpark', 'Graben Amstetten', 'Graben Ulmerfeld', 'Platte', 'Daliebis', 'Bazol', 'Haslat', 'Schüttenacker', 'Graf-Rudolf-Wuhrgang', 'Graf-Hugo-Wuhrgang', 'Churer Tor', 'Gempala', 'Motta', 'Gosta', 'Troja', 'Untere Gosta', 'Obere Gosta', 'Kilknerwald', 'Bonawinkel', 'Inner Tobel', 'Sprisaloch', 'Zerfall', 'Boda', 'Güatli', 'Floßländ', 'Quellenhof', 'Hoher Markt', 'Walchsee', 'Walchsee', 'Waldkirchen an der Thaya', 'Wals-Siezenheim', 'Wattens', 'Weibern', 'Weiden am See', 'Weiler', 'Weißenbach am Lech', 'Weißenkirchen in der Wachau', 'Wels', 'Wiener Neudorf', 'Wiener Neustadt', 'Wieselburg', 'Wildendürnbach', 'Ringmauer', 'Conrad-Lester-Hof', 'Winden am See', 'Schmollfeld', 'Großmühlhäuser', 'Lötz')
		)
		OR
		(
			-- Places that end with "ring" but are not streets for sure.
			street IN (
				'Badhöring', 'Biedring', 'Daring', 'Dobring', 'Ebring', 'Ehring', 'Engljähring', 'Euring', 'Evangelischer Friedhof Simmering', 'Feistring', 'Felbring', 'Feuerhalle Simmering', 'Feuring', 'Fischering', 'Fischhamering', 'Födering', 'Gadering', 'Gattring', 'Geigering', 'Gemering', 'Giering', 'Gimpering', 'Ginshöring', 'Gunsering', 'Guttaring', 'Gössering', 'Habring', 'Hallenbad Simmering', 'Haudering', 'hiering', 'Hilkering', 'Hintering', 'Hintring', 'Höring', 'Ingering II', 'Innernöring', 'Jauring', 'Kaffring', 'Kellnering', 'Kleinsemmering', 'Kring', 'Köfering', 'Kühnring', 'Liedering', 'Littring', 'Mahring', 'Mairing', 'Marchtring', 'Marchtring', 'Mittergafring', 'Mähring', 'Mödring', 'Mühring', 'Niederbairing', 'Oberbairing', 'Obergafring', 'Oberjahring', 'Oberkansering', 'Oberring', 'Oberrühring', 'Oberschöfring', 'Ochsenharing', 'Olsaring', 'Pehring', 'Pengering', 'Pesenlittring', 'Pöbring', 'Pühring', 'Rackering', 'Ragering', 'Reichering', 'Reitering', 'Rubring', 'Rühring', 'Schillering', 'Schnittering', 'Schoppering', 'Seiring', 'Semering', 'Semmering', 'Seyring', 'Silbering', 'Sindhöring', 'Stamering', 'Steiring', 'Unering', 'Unterkansering', 'Unterpassering', 'Uring', 'Vordernöring', 'Wahring', 'Waidring', 'Walkering', 'Wassering', 'Wienering', 'Wolfring', 'Wöbring', 'Wögring', 'Wölzing-Fischering', 'Zintring', 'Zwaring', 'Zwischensimmering', 'Zöbring',

				-- Places that end with "rain" but are not streets for sure.
				'Halbenrain', 'Achrain', 'Draurein', 'Harrain', 'Hochrain', 'Hungerrain', 'Hungerrain', 'Niedermauern-Rain', 'Podrain', 'Rotrain', 'Sellrain', 'Silberrain', 'Unterkrain', 'Wagrain',

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
	)
--GROUP BY municipality, street ORDER BY municipality
;



-- Remove " ,alle [geraden|ungeraden] Zahlen[ des Intervalls]" strings from the house numbers.
UPDATE bev_addresses SET house_number=split_part(house_number, ' ,alle', 1)
  WHERE house_number LIKE '%alle geraden%'
  OR house_number LIKE '%alle ungeraden%';



-- Remove the place name at the end of each "Bahnstraße" in the municipality of Ebreichsdorf.
UPDATE bev_addresses SET street = 'Bahnstraße' WHERE municipality = 'Ebreichsdorf' AND street LIKE 'Bahnstraße %';



-- TODO: Wildschönau. There are several localities which have themselves street names. They are depicted as "Street, locality". They need to be separated.
-- TODO: Wolkersdorf im Weinviertel.