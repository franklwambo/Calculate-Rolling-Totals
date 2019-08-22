select t.year,
t.total_diagnosed,
@running_total:=@running_total + t.total_diagnosed AS cumulative_sum
FROM
(
SELECT YEAR(diagnosis_datetime) as year,COUNT(system_id) as total_diagnosed FROM person_diagnosis
where diagnosis_value_text='POSITIVE' and YEAR(diagnosis_datetime)>=2004
GROUP BY YEAR(diagnosis_datetime)
) t
JOIN (SELECT @running_total:=0) r
ORDER BY t.year;