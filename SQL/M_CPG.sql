CREATE TABLE CPG AS
WITH NORMALIZED_GRADE AS (
	SELECT Student_ID, Course_Num, Section_ID, Term, Year, 'A' AS N_Grade 
	FROM TAKEN WHERE Grade IN ('A', 'A-', 'A+')
	UNION
	SELECT Student_ID, Course_Num, Section_ID, Term, Year, 'B' AS N_Grade 
	FROM TAKEN WHERE Grade IN ('B', 'B-', 'B+')
	UNION
	SELECT Student_ID, Course_Num, Section_ID, Term, Year, 'C' AS N_Grade 
	FROM TAKEN WHERE Grade IN ('C', 'C-', 'C+')
	UNION
	SELECT Student_ID, Course_Num, Section_ID, Term, Year, 'D' AS N_Grade 
	FROM TAKEN WHERE Grade = 'D'
	UNION
	SELECT Student_ID, Course_Num, Section_ID, Term, Year, 'O' AS N_Grade 
	FROM TAKEN WHERE Grade NOT IN (SELECT LETTER_GRADE FROM GRADE_CONVERSION)
)
SELECT DISTINCT t.Course_Num, c.Instructor, t.N_Grade, count(*) AS Num
FROM NORMALIZED_GRADE t, Classes_Sections c
WHERE t.Section_ID = c.Section_ID
GROUP BY t.Course_Num, c.Instructor, t.N_Grade;

CREATE OR REPLACE FUNCTION check_CPG_insert()
RETURNS TRIGGER AS $$
BEGIN
    IF NOT EXISTS (
		SELECT *
		FROM CPG t, CLASSES_SECTIONS c, GRADE_NORMALIZE g
		WHERE NEW.Course_Num = t.Course_Num
			AND c.Instructor = t.Instructor
			AND g.GRADE = t.N_Grade
			AND NEW.Section_ID = c.Section_ID
			AND NEW.Grade = g.LETTER_GRADE
    ) THEN 
		INSERT INTO CPG 
		SELECT DISTINCT o.Course_ID AS Course_Num, c.Instructor, g.Grade AS N_Grade, 1 AS Num
		FROM CLASSES_SECTIONS c, GRADE_NORMALIZE g, OFFERING o
		WHERE o.Section_ID = NEW.Section_ID
			AND o.Section_ID = c.Section_ID
			AND g.LETTER_GRADE = NEW.Grade;
	ELSE
		WITH TEMP AS (
			SELECT DISTINCT o.Course_ID AS Course_Num, c.Instructor, g.Grade AS N_Grade
			FROM CLASSES_SECTIONS c, GRADE_NORMALIZE g, OFFERING o
			WHERE o.Section_ID = NEW.Section_ID
			AND o.Section_ID = c.Section_ID
			AND g.LETTER_GRADE = NEW.Grade
		)
		UPDATE CPG
		SET Num = Num + 1
		WHERE Course_Num in (SELECT Course_Num FROM TEMP)
			AND Instructor in (SELECT Instructor FROM TEMP)
			AND N_Grade in (SELECT N_Grade FROM TEMP);

    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER CPG_INSERT
AFTER INSERT ON TAKEN
FOR EACH ROW
EXECUTE FUNCTION check_CPG_insert();

CREATE OR REPLACE FUNCTION check_CPG_update()
RETURNS TRIGGER AS $$
BEGIN
	WITH TEMP AS (
		SELECT DISTINCT o.Course_ID AS Course_Num, c.Instructor, g.Grade AS N_Grade
		FROM CLASSES_SECTIONS c, GRADE_NORMALIZE g, OFFERING o
		WHERE o.Section_ID = OLD.Section_ID
		AND o.Section_ID = c.Section_ID
		AND g.LETTER_GRADE = OLD.Grade
	)
	UPDATE CPG
	SET Num = Num - 1
	WHERE Course_Num in (SELECT Course_Num FROM TEMP)
		AND Instructor in (SELECT Instructor FROM TEMP)
		AND N_Grade in (SELECT N_Grade FROM TEMP);

    IF NOT EXISTS (
		SELECT *
		FROM CPG t, CLASSES_SECTIONS c, GRADE_NORMALIZE g
		WHERE NEW.Course_Num = t.Course_Num
			AND c.Instructor = t.Instructor
			AND g.GRADE = t.N_Grade
			AND NEW.Section_ID = c.Section_ID
			AND NEW.Grade = g.LETTER_GRADE
    ) THEN 
		INSERT INTO CPG 
		SELECT DISTINCT o.Course_ID AS Course_Num, c.Instructor, g.Grade AS N_Grade, 1 AS Num
		FROM CLASSES_SECTIONS c, GRADE_NORMALIZE g, OFFERING o
		WHERE o.Section_ID = NEW.Section_ID
			AND o.Section_ID = c.Section_ID
			AND g.LETTER_GRADE = NEW.Grade;
	ELSE
		WITH TEMP AS (
			SELECT DISTINCT o.Course_ID AS Course_Num, c.Instructor, g.Grade AS N_Grade
			FROM CLASSES_SECTIONS c, GRADE_NORMALIZE g, OFFERING o
			WHERE o.Section_ID = NEW.Section_ID
			AND o.Section_ID = c.Section_ID
			AND g.LETTER_GRADE = NEW.Grade
		)
		UPDATE CPG
		SET Num = Num + 1
		WHERE Course_Num in (SELECT Course_Num FROM TEMP)
			AND Instructor in (SELECT Instructor FROM TEMP)
			AND N_Grade in (SELECT N_Grade FROM TEMP);

    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER CPG_UPDATE
AFTER UPDATE ON TAKEN
FOR EACH ROW
EXECUTE FUNCTION check_CPG_update();

CREATE OR REPLACE FUNCTION check_CPG_delete()
RETURNS TRIGGER AS $$
BEGIN
	WITH TEMP AS (
		SELECT DISTINCT o.Course_ID AS Course_Num, c.Instructor, g.Grade AS N_Grade
		FROM CLASSES_SECTIONS c, GRADE_NORMALIZE g, OFFERING o
		WHERE o.Section_ID = OLD.Section_ID
		AND o.Section_ID = c.Section_ID
		AND g.LETTER_GRADE = OLD.Grade
	)
	UPDATE CPG
	SET Num = Num - 1
	WHERE Course_Num in (SELECT Course_Num FROM TEMP)
		AND Instructor in (SELECT Instructor FROM TEMP)
		AND N_Grade in (SELECT N_Grade FROM TEMP);

    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER CPG_DELETE
AFTER DELETE ON TAKEN
FOR EACH ROW
EXECUTE FUNCTION check_CPG_delete();





