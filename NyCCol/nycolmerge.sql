drop table if exists NYCOL;
create table NYCOL as
	select c.*, p.PERSON_ID, p.PERSON_TYPE, p.PERSON_ROLE, p.PERSON_AGE, p.PERSON_SEX, p.PERSON_INJURY,
			v.VEHICLE_ID, p.SAFETY_EQUIPMENT, v.STATE_REGISTRATION, v.VEHICLE_CATEGORY, v.VEHICLE_YEAR,
			v.DRIVER_LICENSE_STATUS, v.DRIVER_LICENSE_JURISDICTION, v.PRIMARY_CONTRIBUTING_FACTOR
		from CRASH_2NF c
				left join PERSON_2NF p on c.COLLISION_ID = p.COLLISION_ID
				left join VEHICLE_2NF v on c.COLLISION_ID = v.COLLISION_ID and p.VEHICLE_ID = v.VEHICLE_ID
;
select * from NYCOL;
