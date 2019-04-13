SELECT TOP(10)
	'"Patient ID"' = i.ida,
	'"Last Name"' = p.last_name,
    '"First Name"' = p.first_name,
    '"Course No"' = d.course,
    '"Technique"' = ltrim(rtrim(d.technique)),
    '"Machine"' = LTRIM(RTRIM(f.last_name)),
    '"Sit_set_id"' = d.sit_set_id

FROM dosesummarysnapshot d

LEFT JOIN ident i ON d.pat_id1 = i.pat_id1
LEFT JOIN patient p ON d.pat_id1 = p.pat_id1
LEFT JOIN site s ON d.sit_id = s.sit_id
LEFT JOIN dose_hst dh ON s.sit_id = dh.sit_id
LEFT JOIN staff f ON dh.machine_id_staff_id = f.staff_id


WHERE i.ida NOT IN ('01', '123128v', '10000000000', '2000000000','0000001', 'FUNCTION_CHECK' )
	AND ( ( i.ident_id IS NULL OR i.ident_id = 0 ) OR i.version = 0 )

GROUP BY

	d.sit_set_id,
	i.ida,
	p.last_name,
	p.first_name,
	d.course,
	d.start_dttm,
  	d.technique,
  	f.last_name

ORDER BY
	i.ida,
	d.start_dttm,
	d.course
