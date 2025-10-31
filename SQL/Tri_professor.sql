CREATE OR REPLACE FUNCTION check_professor()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM CLASSES_SECTIONS c1
        JOIN OFFERING o1 ON c1.Section_ID = o1.Section_ID
        WHERE c1.Instructor = NEW.Instructor
        AND o1.Term = (SELECT Term FROM OFFERING WHERE Section_ID = NEW.Section_ID)
        AND o1.Year_C = (SELECT Year_C FROM OFFERING WHERE Section_ID = NEW.Section_ID)
        AND c1.Type_M = 'LE'
        AND NEW.Type_M = 'LE'
        AND c1.Section_ID <> NEW.Section_ID
        AND (
            NEW.Start_Time < c1.End_Time 
            AND NEW.End_Time > c1.Start_Time
        )
        AND (
            POSITION('M' IN NEW.Days_C) > 0 AND POSITION('M' IN c1.Days_C) > 0 OR
            POSITION('T' IN NEW.Days_C) > 0 AND POSITION('T' IN c1.Days_C) > 0 AND POSITION('Th' IN NEW.Days_C) = 0 AND POSITION('Th' IN c1.Days_C) = 0 OR
            POSITION('W' IN NEW.Days_C) > 0 AND POSITION('W' IN c1.Days_C) > 0 OR
            POSITION('Th' IN NEW.Days_C) > 0 AND POSITION('Th' IN c1.Days_C) > 0 OR
            POSITION('F' IN NEW.Days_C) > 0 AND POSITION('F' IN c1.Days_C) > 0
        )
    )
    THEN
        RAISE EXCEPTION 'New Section % Conflicting with Instructor % Existing Section(s)', NEW.Section_ID, NEW.Instructor;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER tri_professor
AFTER INSERT OR UPDATE ON CLASSES_SECTIONS
FOR EACH ROW
EXECUTE FUNCTION check_professor();
