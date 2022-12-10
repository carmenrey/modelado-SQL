-- Creo el espacio de trabajo
create schema carmenreyglez authorization vezgldfh;

--- CREACIÓN DE TABLAS ---
--- TABLA COLORES --- 
create table carmenreyglez.colors(
	idColor varchar (10) not null, -- PK
	color varchar (40) not null, -- nombre del color
	description varchar (250) null
);

-- PK
alter table carmenreyglez.colors
add constraint colors_PK primary key (idColor);


--- TABLA COMPAÑÍAS ASEGURADORAS ---
create table carmenreyglez.insurance_companies(
	idCompany varchar (10) not null, -- PK
	name_co varchar (40) not null, -- nombre de la compañía
	description varchar (250) null
);

-- PK
alter table carmenreyglez.insurance_companies
add constraint ins_companies_PK primary key (idCompany);


--- TABLA PÓLIZAS ---
create table carmenreyglez.insurance_policies(
	idPolicy varchar (10) not null, -- PK
	policy_no varchar (40) not null, -- número de póliza
	description varchar (250) null
);

-- PK pólizas
alter table carmenreyglez.insurance_policies
add constraint ins_policies_PK primary key (idPolicy);


--- TABLA MONEDAS ---
create table carmenreyglez.currencies(
	idCurrency varchar (10) not null, -- PK
	name_currency varchar (40) not null, -- nombre de la moneda
	description varchar (250) null
);

-- PK monedas
alter table carmenreyglez.currencies
add constraint currencies_PK primary key (idCurrency);


--- TABLA GRUPOS EMPRESARIALES ---
create table carmenreyglez.corporations(
	idCorporation varchar (10) not null, -- PK
	corporation varchar (40) not null, -- nombre del grupo empresarial
	description varchar (250) null
);

-- PK grupo empresarial
alter table carmenreyglez.corporations
add constraint corporations_PK primary key (idCorporation);


--- TABLA MARCAS ---
create table carmenreyglez.brands(
	idBrand varchar (10) not null, -- PK
	brand varchar (40) not null, -- nombre de la marca
	idCorporation varchar (10) not null, -- FK -> carmenreyglez.corporations (idCorporation)
	description varchar (250) null
);

-- PK marcas
alter table carmenreyglez.brands
add constraint brands_PK primary key (idBrand);

-- FK marcas -> grupo empresarial
alter table carmenreyglez.brands
add constraint brands_corp_FK foreign key (idCorporation)
references carmenreyglez.corporations (idCorporation);


--- TABLA MODELOS ---
create table carmenreyglez.models(
	idModel varchar (10) not null, -- PK
	model varchar (40) not null, -- nombre del modelo
	idBrand varchar (10) not null, -- FK1 -> carmenreyglez.brands (idBrand)
	idCorporation varchar (10) not null, -- FK2 -> carmenreyglez.corporations (idCorporation)
	description varchar (250) null
);

-- PK modelos
alter table carmenreyglez.models
add constraint models_PK primary key (idModel);

-- FK modelos -> marcas
alter table carmenreyglez.models
add constraint models_brands_FK foreign key (idBrand)
references carmenreyglez.brands (idBrand);

-- FK modelos -> grupo empresarial
alter table carmenreyglez.models
add constraint models_corp_FK foreign key (idCorporation)
references carmenreyglez.corporations (idCorporation);


--- TABLA COCHES ---
create table carmenreyglez.vehicles(
	idVehicle varchar (10) not null, -- PK
	idModel varchar (10) not null, -- FK -> carmenreyglez.models (idModel)
	idColor varchar (10) not null, -- FK -> carmenreyglez.colors (idColor)
	license_plate varchar (15) not null, -- número de matrícula
	total_no_km integer not null, -- número total de kilómetros del coche
	idCompany varchar (10) not null, -- FK -> carmenreyglez.insurance_companies (idCompany)
	idPolicy varchar (10) not null, -- FK -> carmenreyglez.insurance_policies (idPolicy)
	purchase_date date not null, -- fecha de compra
	last_update date not null, -- fecha actual para saber cuándo se han actualizado los km totales
	description varchar (250) null
);

-- PK coches
alter table carmenreyglez.vehicles
add constraint vehicles_PK primary key (idVehicle);

-- FK coches -> modelos
alter table carmenreyglez.vehicles
add constraint vehicles_models_FK foreign key (idModel)
references carmenreyglez.models (idModel);

-- FK coches -> colores
alter table carmenreyglez.vehicles
add constraint vehicles_colors_FK foreign key (idColor)
references carmenreyglez.colors (idColor);

-- FK coches -> compañías aseguradoras
alter table carmenreyglez.vehicles
add constraint vehicles_companies_FK foreign key (idCompany)
references carmenreyglez.insurance_companies (idCompany);

-- FK coches -> pólizas
alter table carmenreyglez.vehicles
add constraint vehicles_policies_FK foreign key (idPolicy)
references carmenreyglez.insurance_policies (idPolicy);


--- TABLA REVISIONES ---
create table carmenreyglez.inspections(
	idVehicle varchar (10) not null, -- PK, FK -> carmenreyglez.vehicles (idVehicle)
	inspection_date date not null, -- PK
	no_km integer not null, -- número de km en el momento de la revisión
	amount decimal(8, 2) not null, -- importe de la revisión (8 dígitos con 2 decimales)
	idCurrency varchar (10) not null, -- FK -> carmenreyglez.currencies (idCurrency)
	description varchar (250) null
);

-- PK revisiones
alter table carmenreyglez.inspections
add constraint inspections_PK primary key (idVehicle, inspection_date);

-- FK revisiones -> coches
alter table carmenreyglez.inspections
add constraint inspec_vehicles_FK foreign key (idVehicle)
references carmenreyglez.vehicles (idVehicle);

-- FK revisiones -> monedas
alter table carmenreyglez.inspections
add constraint inspec_currencies_FK foreign key (idCurrency)
references carmenreyglez.currencies (idCurrency);


--- INTRODUCCIÓN DE DATOS ---
-- Tabla colores
insert into carmenreyglez.colors (idColor, color, description) values ('1' , 'Rojo', '');
insert into carmenreyglez.colors (idColor, color, description) values ('2' , 'Negro', '');
insert into carmenreyglez.colors (idColor, color, description) values ('3' , 'Blanco', '');
insert into carmenreyglez.colors (idColor, color, description) values ('4' , 'Azul', '');
insert into carmenreyglez.colors (idColor, color, description) values ('5' , 'Verde', '');
insert into carmenreyglez.colors (idColor, color, description) values ('6' , 'Gris', '');


--- Tabla grupos empresariales ---
insert into carmenreyglez.corporations (idCorporation, corporation, description) values ('G01' , 'BMW Group', '');
insert into carmenreyglez.corporations (idCorporation, corporation, description) values ('G02' , 'Daimler', '');
insert into carmenreyglez.corporations (idCorporation, corporation, description) values ('G03' , 'FCA', '');


--- Tabla marcas ---
insert into carmenreyglez.brands (idBrand, brand, idCorporation, description) values ('MA01' , 'BMW', 'G01', '');
insert into carmenreyglez.brands (idBrand, brand, idCorporation, description) values ('MA02' , 'Rolls Royce', 'G01', '');
insert into carmenreyglez.brands (idBrand, brand, idCorporation, description) values ('MA03' , 'Mini', 'G01', '');
insert into carmenreyglez.brands (idBrand, brand, idCorporation, description) values ('MA04' , 'Mercedes-Benz', 'G02', '');
insert into carmenreyglez.brands (idBrand, brand, idCorporation, description) values ('MA05' , 'Jeep', 'G03', '');
insert into carmenreyglez.brands (idBrand, brand, idCorporation, description) values ('MA06' , 'Alfa Romeo', 'G03', '');


--- Tabla modelos ---
insert into carmenreyglez.models (idModel, model, idBrand, idCorporation, description) values ('M01' , 'Serie 1', 'MA01', 'G01', '');
insert into carmenreyglez.models (idModel, model, idBrand, idCorporation, description) values ('M02' , 'X5', 'MA01', 'G01', '');
insert into carmenreyglez.models (idModel, model, idBrand, idCorporation, description) values ('M03' , 'Ghost', 'MA02', 'G01', '');
insert into carmenreyglez.models (idModel, model, idBrand, idCorporation, description) values ('M04' , 'Cooper', 'MA03', 'G01', '');
insert into carmenreyglez.models (idModel, model, idBrand, idCorporation, description) values ('M05' , 'EQA', 'MA04', 'G02', '');
insert into carmenreyglez.models (idModel, model, idBrand, idCorporation, description) values ('M06' , 'EQB', 'MA04', 'G02', '');
insert into carmenreyglez.models (idModel, model, idBrand, idCorporation, description) values ('M07' , 'Renegade', 'MA05', 'G03', '');
insert into carmenreyglez.models (idModel, model, idBrand, idCorporation, description) values ('M08' , 'Grand Cherokee', 'MA05', 'G03', '');
insert into carmenreyglez.models (idModel, model, idBrand, idCorporation, description) values ('M09' , 'Giulietta', 'MA06', 'G03', '');


--- Tabla compañías aseguradoras ---
insert into carmenreyglez.insurance_companies (idCompany, name_co, description) values ('A01' , 'Allianz', '');
insert into carmenreyglez.insurance_companies (idCompany, name_co, description) values ('A02' , 'AXA', '');
insert into carmenreyglez.insurance_companies (idCompany, name_co, description) values ('A03' , 'Generali', '');
insert into carmenreyglez.insurance_companies (idCompany, name_co, description) values ('A04' , 'Mapfre', '');
insert into carmenreyglez.insurance_companies (idCompany, name_co, description) values ('A05' , 'Mutua Madrileña', '');
insert into carmenreyglez.insurance_companies (idCompany, name_co, description) values ('A06' , 'Pelayo', '');


--- Tabla pólizas ---
insert into carmenreyglez.insurance_policies (idPolicy, policy_no, description) values ('P01' , 'X123CD', '');
insert into carmenreyglez.insurance_policies (idPolicy, policy_no, description) values ('P02' , 'X345FR', '');
insert into carmenreyglez.insurance_policies (idPolicy, policy_no, description) values ('P03' , 'X456RE', '');
insert into carmenreyglez.insurance_policies (idPolicy, policy_no, description) values ('P04' , 'X987DW', '');
insert into carmenreyglez.insurance_policies (idPolicy, policy_no, description) values ('P05' , 'X326TG', '');
insert into carmenreyglez.insurance_policies (idPolicy, policy_no, description) values ('P06' , 'X245TE', '');
insert into carmenreyglez.insurance_policies (idPolicy, policy_no, description) values ('P07' , 'X120VF', '');
insert into carmenreyglez.insurance_policies (idPolicy, policy_no, description) values ('P08' , 'X012DE', '');
insert into carmenreyglez.insurance_policies (idPolicy, policy_no, description) values ('P09' , 'X789SE', '');
insert into carmenreyglez.insurance_policies (idPolicy, policy_no, description) values ('P10' , 'X654BN', '');
insert into carmenreyglez.insurance_policies (idPolicy, policy_no, description) values ('P11' , 'X678RT', '');
insert into carmenreyglez.insurance_policies (idPolicy, policy_no, description) values ('P12' , 'X264GT', '');
insert into carmenreyglez.insurance_policies (idPolicy, policy_no, description) values ('P13' , 'X269HT', '');
insert into carmenreyglez.insurance_policies (idPolicy, policy_no, description) values ('P14' , 'X104RE', '');
insert into carmenreyglez.insurance_policies (idPolicy, policy_no, description) values ('P15' , 'X395SS', '');


--- Tabla monedas ---
insert into carmenreyglez.currencies (idCurrency, name_currency, description) values ('EUR' , 'Euro', '');
insert into carmenreyglez.currencies (idCurrency, name_currency, description) values ('USD' , 'Dolar americano', '');
insert into carmenreyglez.currencies (idCurrency, name_currency, description) values ('GBP' , 'Libra esterlina', '');
insert into carmenreyglez.currencies (idCurrency, name_currency, description) values ('GPY' , 'Yen', '');


--- Tabla coches ---
insert into carmenreyglez.vehicles (idVehicle, idModel, idColor, license_plate, total_no_km, idCompany, idPolicy, purchase_date, last_update, description) values ('V001' , 'M01', '1', '1234KKK', '110000', 'A01', 'P01', '2020-01-01', now(), '');
insert into carmenreyglez.vehicles (idVehicle, idModel, idColor, license_plate, total_no_km, idCompany, idPolicy, purchase_date, last_update, description) values ('V002' , 'M02', '2', '4567LLL', '105000', 'A01', 'P02', '2020-02-02', now(), '');
insert into carmenreyglez.vehicles (idVehicle, idModel, idColor, license_plate, total_no_km, idCompany, idPolicy, purchase_date, last_update, description) values ('V003' , 'M01', '3', '7890NNN', '90000', 'A02', 'P03', '2020-03-03', now(), '');
insert into carmenreyglez.vehicles (idVehicle, idModel, idColor, license_plate, total_no_km, idCompany, idPolicy, purchase_date, last_update, description) values ('V004' , 'M03', '1', '9012HHH', '85000', 'A01', 'P04', '2020-04-04', now(), '');
insert into carmenreyglez.vehicles (idVehicle, idModel, idColor, license_plate, total_no_km, idCompany, idPolicy, purchase_date, last_update, description) values ('V005' , 'M03', '2', '3456BBB', '77000', 'A03', 'P05', '2021-05-05', now(), '');
insert into carmenreyglez.vehicles (idVehicle, idModel, idColor, license_plate, total_no_km, idCompany, idPolicy, purchase_date, last_update, description) values ('V006' , 'M04', '3', '5678GGG', '65000', 'A03', 'P06', '2021-06-06', now(), '');
insert into carmenreyglez.vehicles (idVehicle, idModel, idColor, license_plate, total_no_km, idCompany, idPolicy, purchase_date, last_update, description) values ('V007' , 'M05', '1', '9874JJJ', '77000', 'A02', 'P07', '2021-06-06', now(), '');
insert into carmenreyglez.vehicles (idVehicle, idModel, idColor, license_plate, total_no_km, idCompany, idPolicy, purchase_date, last_update, description) values ('V008' , 'M02', '2', '3210PPP', '60000', 'A03', 'P08', '2021-10-08', now(), '');
insert into carmenreyglez.vehicles (idVehicle, idModel, idColor, license_plate, total_no_km, idCompany, idPolicy, purchase_date, last_update, description) values ('V009' , 'M05', '2', '6789DDD', '62000', 'A02', 'P09', '2021-11-09', now(), '');
insert into carmenreyglez.vehicles (idVehicle, idModel, idColor, license_plate, total_no_km, idCompany, idPolicy, purchase_date, last_update, description) values ('V010' , 'M04', '4', '5432FFF', '10000', 'A04', 'P10', '2021-12-10', now(), '');
insert into carmenreyglez.vehicles (idVehicle, idModel, idColor, license_plate, total_no_km, idCompany, idPolicy, purchase_date, last_update, description) values ('V011' , 'M06', '5', '5689WWW', '25000', 'A06', 'P11', '2021-12-10', now(), '');
insert into carmenreyglez.vehicles (idVehicle, idModel, idColor, license_plate, total_no_km, idCompany, idPolicy, purchase_date, last_update, description) values ('V012' , 'M07', '5', '7854PPP', '35000', 'A05', 'P12', '2021-12-10', now(), '');
insert into carmenreyglez.vehicles (idVehicle, idModel, idColor, license_plate, total_no_km, idCompany, idPolicy, purchase_date, last_update, description) values ('V013' , 'M08', '6', '1254FFF', '5000', 'A05', 'P13', '2022-05-11', now(), '');
insert into carmenreyglez.vehicles (idVehicle, idModel, idColor, license_plate, total_no_km, idCompany, idPolicy, purchase_date, last_update, description) values ('V014' , 'M09', '2', '3569AAA', '15000', 'A04', 'P14', '2022-05-15', now(), '');
insert into carmenreyglez.vehicles (idVehicle, idModel, idColor, license_plate, total_no_km, idCompany, idPolicy, purchase_date, last_update, description) values ('V015' , 'M07', '6', '1236CCC', '13000', 'A06', 'P15', '2022-06-01', now(), '');


--- Tabla revisiones ---
insert into carmenreyglez.inspections (idVehicle, inspection_date, no_km, amount, idCurrency, description) values ('V001' , '2021-01-01', '50000', '50', 'EUR', '');
insert into carmenreyglez.inspections (idVehicle, inspection_date, no_km, amount, idCurrency, description) values ('V001' , '2022-01-01', '80000', '56', 'USD', '');
insert into carmenreyglez.inspections (idVehicle, inspection_date, no_km, amount, idCurrency, description) values ('V002' , '2021-02-01', '55000', '50', 'EUR', '');
insert into carmenreyglez.inspections (idVehicle, inspection_date, no_km, amount, idCurrency, description) values ('V002' , '2022-02-02', '87500', '57.60', 'USD', '');
insert into carmenreyglez.inspections (idVehicle, inspection_date, no_km, amount, idCurrency, description) values ('V003' , '2021-03-10', '40000', '56', 'EUR', '');
insert into carmenreyglez.inspections (idVehicle, inspection_date, no_km, amount, idCurrency, description) values ('V003' , '2022-03-02', '77500', '59', 'EUR', '');
insert into carmenreyglez.inspections (idVehicle, inspection_date, no_km, amount, idCurrency, description) values ('V004' , '2021-04-04', '60000', '63.80', 'GBP', '');
insert into carmenreyglez.inspections (idVehicle, inspection_date, no_km, amount, idCurrency, description) values ('V004' , '2022-04-15', '75000', '58', 'EUR', '');
insert into carmenreyglez.inspections (idVehicle, inspection_date, no_km, amount, idCurrency, description) values ('V005' , '2022-04-04', '60000', '60', 'EUR', '');
insert into carmenreyglez.inspections (idVehicle, inspection_date, no_km, amount, idCurrency, description) values ('V006' , '2022-06-24', '60000', '63', 'EUR', '');
insert into carmenreyglez.inspections (idVehicle, inspection_date, no_km, amount, idCurrency, description) values ('V007' , '2022-06-24', '67000', '63', 'EUR', '');
insert into carmenreyglez.inspections (idVehicle, inspection_date, no_km, amount, idCurrency, description) values ('V008' , '2022-10-08', '55000', '59', 'EUR', '');
insert into carmenreyglez.inspections (idVehicle, inspection_date, no_km, amount, idCurrency, description) values ('V009' , '2022-10-08', '55500', '0.48', 'GPY', '');

