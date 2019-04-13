SELECT DISTINCT
    MIN(d.start_dttm) as date,
    i.ida as patient_id,
    p.last_name,
    p.first_name,
    p.birth_dttm as birthday,
    d.course,
    MIN(LTRIM(RTRIM(s.last_name))) as system,
    t.diag_code,
    LTRIM(RTRIM(t.description)) as description
FROM dosesummarysnapshot d
LEFT JOIN patient p ON d.pat_id1 = p.pat_id1
LEFT JOIN ident i ON d.pat_id1 = i.pat_id1
LEFT JOIN schedule sch ON d.sch_id = sch.sch_id
LEFT JOIN staff s ON sch.location = s.staff_id
LEFT JOIN site sit ON d.sit_id = sit.sit_id
LEFT JOIN txfield tx ON sit.sit_set_id = tx.sit_set_id
LEFT JOIN patcplan pcp ON sit.pcp_id = pcp.pcp_id
LEFT JOIN medical med ON pcp.med_id = med.med_id
LEFT JOIN topog t ON med.tpg_id = t.tpg_id
WHERE   s.last_name NOT LIKE '%ARZT%'
    AND s.last_name NOT LIKE '%THERAPIE'
--    AND s.last_name LIKE ?
    AND (d.start_dttm) > DATEADD(day, -1, ?)
    AND d.start_dttm < ?
--    AND t.diag_code LIKE ?
GROUP BY
        d.course,
        i.ida,
        p.last_name,
        p.first_name,
        p.birth_dttm,
        t.diag_code,
        t.description,
        sit.site_name
ORDER BY
        date,
        i.ida,
        d.course
