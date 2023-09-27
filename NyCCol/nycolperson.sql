drop table if exists PERSON_1NF;
create table PERSON_1NF (
  PERSON_ID INTEGER,
  COLLISION_ID INTEGER,
  PERSON_TYPE TEXT,
  PERSON_ROLE TEXT,
  PERSON_AGE INTEGER,
  PERSON_SEX TEXT,
  PERSON_INJURY TEXT,
  VEHICLE_ID INTEGER,
  SAFETY_EQUIPMENT TEXT,
  PRIMARY KEY (PERSON_ID)
);
insert into PERSON_1NF
	select UNIQUE_ID, COLLISION_ID, PERSON_TYPE,
			case when PERSON_TYPE='In-Line Skater' then 'Driver' else PED_ROLE end as PERSON_ROLE,
			case when cast(PERSON_AGE as Integer) < 0 or cast(PERSON_AGE as integer)  > 120 then NULL else PERSON_AGE end as PERSON_AGE,
			case when PERSON_SEX is NULL then 'U' else PERSON_SEX end as PERSON_SEX,
			PERSON_INJURY, VEHICLE_ID, SAFETY_EQUIPMENT
		from PERSON_0NF
		where PERSON_ROLE is not NULL and PERSON_ROLE not in ('Owner','Registrant','Witness','Notified Person','Other')
;
