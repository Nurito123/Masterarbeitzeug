SELECT
	'"Patient ID ida"' = i.ida,
  '"Patient ID pat_id1"' = i.pat_id1,
	'"Last Name"' = p.last_name,
  '"First Name"' = p.first_name,
  '"Patient ID"' = i.ida,
  '"Birthday"' = p.birth_dttm

FROM ident i

LEFT JOIN patient p ON i.pat_id1 = p.pat_id1

WHERE i.ida = '1008095020'

--'1013070373'
