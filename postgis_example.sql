-- EJEMPLO DE CONVERSIÓN DE COORDENADAS EN BASE DE DATOS CON POSTGIS


--- DE GEOGRAFICAS (WGS84) A ETRS89 / UTM zone 31N  


-- punto en wgs84
SELECT st_setsrid(st_makepoint(2.1423661709,41.3361132145),4326) as punto_wgs84;


-- punto tranformado en ETRS89 / UTM zone 31N  

SELECT st_transform(sub.punto_wgs84, 25831) as punto_utm FROM 
(
	SELECT st_setsrid(st_makepoint(2.1423661709,41.3361132145),4326) as punto_wgs84
) as sub;


-- Extraigo coordenadas x y 

SELECT st_x(transformado.punto_utm) as coordx, st_y(transformado.punto_utm) as coordy  FROM (
	
	SELECT st_transform(sub.punto_wgs84, 25831) as punto_utm FROM 
	(
		SELECT st_setsrid(st_makepoint(2.1423661709,41.3361132145),4326) as punto_wgs84
	) as sub
)as transformado;


---  DE ETRS89 / UTM zone 31N  A DE GEOGRAFICAS (WGS84)

-- punto en utm
SELECT st_setsrid(st_makepoint(428238.9899222932,4576424.650294064),25831) as punto_utm;


-- punto tranformado en WGS84
SELECT st_transform(sub.punto_utm, 4326) as punto_wgs84 FROM 
(
	SELECT st_setsrid(st_makepoint(428238.9899222932,4576424.650294064),25831) as punto_utm
) as sub;


-- Extraigo coordenadas lon, lat 

SELECT st_x(transformado.punto_wgs84) as lon, st_y(transformado.punto_wgs84) as lat  FROM (
	
	SELECT st_transform(sub.punto_utm, 4326) as punto_wgs84 FROM 
(
	SELECT st_setsrid(st_makepoint(428238.9899222932,4576424.650294064),25831) as punto_utm
) as sub
)as transformado;