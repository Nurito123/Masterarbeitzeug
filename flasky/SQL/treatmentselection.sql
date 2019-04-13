SELECT
  '"pat_id1"' = d.pat_id1,
	'"d.sit_id"' = d.sit_id,
  '"course"' = d.course,
  '"d.site_name"' = d.site_name,
	'"d.create_dttm"' = d.create_dttm,
	'"dh.fld_id"' = dh.fld_id,
	'"txf.originalplanuid"' = LTRIM(RTRIM(txf.originalplanuid)),
	'"txf.field_label"' = txf.field_label,
	'"txf.field_name"' = txf.field_name

FROM dosesummarysnapshot d

LEFT JOIN dose_hst dh ON d.sit_id = dh.sit_id
LEFT JOIN txfield txf ON dh.fld_id = txf.fld_id

WHERE d.pat_id1 = ?
AND d.issessioncountedasfx = 1
AND d.create_dttm > ?
AND d.create_dttm < ?
AND dh.metersetunit_enum = 1
