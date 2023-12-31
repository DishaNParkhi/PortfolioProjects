drop table if exists VEHICLE_1NF;
create table VEHICLE_1NF (
  VEHICLE_ID INTEGER,
  COLLISION_ID INTEGER, 
  STATE_REGISTRATION TEXT,
  VEHICLE_CATEGORY TEXT,
  VEHICLE_YEAR INTEGER,
  DRIVER_LICENSE_STATUS TEXT,
  DRIVER_LICENSE_JURISDICTION TEXT,
  PRIMARY_CONTRIBUTING_FACTOR TEXT,
  PRIMARY KEY (VEHICLE_ID)
);


insert into VEHICLE_1NF
	select UNIQUE_ID, COLLISION_ID, STATE_REGISTRATION,VL.VEHICLE_CATEGORY, VEHICLE_YEAR, DRIVER_LICENSE_STATUS, DRIVER_LICENSE_JURISDICTION,
			case when CONTRIBUTING_FACTOR_1 is null then 'Unspecified' else CONTRIBUTING_FACTOR_1 end as PRIMARY_CONTRIBUTING_FACTOR
		from VEHICLE_0NF V INNER JOIN VEHICLE_TYPE_TO_CATEGORY VL ON V.VEHICLE_TYPE = VL.VEHICLE_TYPE
		where VL.VEHICLE_TYPE is not '0';
;
/*
DROP TABLE if EXISTS VEHICLE_1NF_vehicle_type;
create TABLE VEHICLE_1NF_vehicle_type as
select *
from VEHICLE_1NF  inner join VEHICLE_TYPE_TO_CATEGORY  on VEHICLE_1NF.VEHICLE_CATEGORY = VEHICLE_TYPE_TO_CATEGORY.VEHICLE_TYPE;
*/