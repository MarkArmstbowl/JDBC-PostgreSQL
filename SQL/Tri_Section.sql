CREATE OR REPLACE FUNCTION check_time()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT *
        FROM CLASSES_SECTIONS c1, CLASSES_SECTIONS c2
        WHERE c1.Section_ID = NEW.Section_ID 
        AND c2.Section_ID = NEW.Section_ID 
        AND c1.Type_M <> c2.Type_M 
        AND (
            c1.Start_Time < c2.End_Time 
            AND c1.End_Time > c2.Start_Time
        )
        AND (
            POSITION('M' IN c1.Days_C) > 0 AND POSITION('M' IN c2.Days_C) > 0 OR
            POSITION('T' IN c1.Days_C) > 0 AND POSITION('T' IN c2.Days_C) > 0 AND POSITION('Th' IN c1.Days_C) = 0 AND POSITION('Th' IN c2.Days_C) = 0 OR
            POSITION('W' IN c1.Days_C) > 0 AND POSITION('W' IN c2.Days_C) > 0 OR
            POSITION('Th' IN c1.Days_C) > 0 AND POSITION('Th' IN c2.Days_C) > 0 OR
            POSITION('F' IN c1.Days_C) > 0 AND POSITION('F' IN c2.Days_C) > 0
        )
    )
    THEN RAISE EXCEPTION 'Time Conflict Within New Entered Sections %', NEW.Section_ID;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tri_time
AFTER INSERT OR UPDATE ON CLASSES_SECTIONS
FOR EACH ROW
EXECUTE FUNCTION check_time();
