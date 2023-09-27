drop table if exists DenormalizedData;
create table DenormalizedData as
select L.*, V.PctVaxCovEst, sum(I.Incidence) as Incidence, sum(I.Visits) as Visits, avg(P.Projection) as Population
	from ILILevel L
		left join FluVaxCovEst V on L.State = V.State and L.EndOfMonth = V.EndOfMonth
		left join EpiWeekToEndOfMonthLookup E on L.EndOfMonth = E.EndOfMonth
		left join ILIIncidence I on L.State = I.State and E.EpiYear = I.EpiYear and E.EpiWeek = I.EpiWeek
		left join Population P on L.State = P.State and E.EpiYear = P.Year
	group by L.State, L.EndOfMonth;