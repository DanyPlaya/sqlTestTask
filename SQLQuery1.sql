WITH RecursiveSubdivisions AS (
    SELECT id, name, parent_id, 0 AS sub_level
    FROM dbo.subdivisions
    WHERE id = 100051 

    UNION ALL

    SELECT s.id, s.name, s.parent_id, rs.sub_level + 1
    FROM dbo.subdivisions s
    INNER JOIN RecursiveSubdivisions rs ON s.parent_id = rs.id
)


SELECT c.id, c.name, rs.name AS sub_name, c.subdivision_id AS sub_id, rs.sub_level,
    COUNT(*) OVER (PARTITION BY c.subdivision_id) AS colls_count
FROM dbo.collaborators c
JOIN RecursiveSubdivisions rs ON c.subdivision_id = rs.id
WHERE c.age < 40 AND LEN(c.name) > 11
    AND c.subdivision_id <> 100055
ORDER BY rs.sub_level;
