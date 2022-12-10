--- CONSULTA SQL ---
-- Sacar el listado de coches con los siguientes datos:
--		- Nombre modelo, marca y grupo de coches
-- 		- Fecha de compra
-- 		- Matrícula
-- 		- Nombre del color del coche
-- 		- Total kilómetros
-- 		- Nombre empresa que está asegurado el coche
-- 		- Número de póliza

select a.idvehicle, b.model, c.brand, d.corporation, a.purchase_date, a.license_plate, e.color, a.total_no_km, f.name_co, g.policy_no
from carmenreyglez.vehicles a, carmenreyglez.models b, carmenreyglez.brands c, carmenreyglez.corporations d, carmenreyglez.colors e,
carmenreyglez.insurance_companies f, carmenreyglez.insurance_policies g 
where a.idmodel = b.idmodel and b.idbrand = c.idbrand and c.idcorporation = d.idcorporation and a.idcolor = e.idcolor 
and a.idcompany = f.idcompany and a.idpolicy = g.idpolicy;
