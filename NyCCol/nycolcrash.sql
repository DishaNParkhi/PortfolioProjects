drop table if exists CRASH_1NF;
create table CRASH_1NF (
  COLLISION_ID INTEGER,
  CRASHDATETIME DATE,
  BOROUGH TEXT,
  COUNTY TEXT,
  STATE TEXT,
  ZIPCODE TEXT,
  LATITUDE REAL,
  LONGITUDE REAL,
  PRIMARY KEY (COLLISION_ID)
);
insert into CRASH_1NF
	select COLLISION_ID, substr(CRASHDATE,7,4)||'-'||substr(CRASHDATE,1,2)||'-'||substr(CRASHDATE,4,2)
			||' '||case when length(CRASHTIME)=4 then '0'||CRASHTIME else CRASHTIME end||':00' as CRASHDATETIME,
			BOROUGH,
			case
				when BOROUGH='BROOKLYN' then 'Kings'
				when BOROUGH='MANHATTAN' then 'New York'
				when BOROUGH='STATEN ISLAND' then 'Richmond'
				when BOROUGH = 'QUEENS' then 'Queens'
				else BOROUGH
			end as COUNTY,
			'NY' as STATE,
			ZIPCODE,
			LATITUDE,
			LONGITUDE
		from CRASH_0NF
		where CRASHDATETIME >= '2019-01-01 00:00:00' and BOROUGH is not NULL
;
