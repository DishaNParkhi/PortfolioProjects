create table iflixmerge as
select p.provider_id, p.provider, s.show_id, s.title, s.show_type, s.release_year, s.age_certification, s.runtime, s.seasons, s.tmdb_popularity, s.tmdb_score, i.averageRating as imdb_rating, i.numVotes as imdb_votes, g.genre_id, g.genre
	from ProviderShow_2NF ps
			left join Provider_2NF p on ps.provider_id = p.provider_id
			left join Show_2NF s on ps.show_id = s.show_id and ps.show_type = s.show_type
			left join IMDbLookup_2NF l on s.show_id = l.show_id and s.show_type = l.show_type
			left join IMDbRating_2NF i on l.tconst = i.tconst
			left join Genre_2NF g on ps.genre_id = g.genre_id
;
