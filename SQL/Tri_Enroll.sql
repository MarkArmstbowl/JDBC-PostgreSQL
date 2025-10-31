CREATE OR REPLACE FUNCTION check_enroll()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT *
        FROM Classes c1
        WHERE c1.Section_ID = NEW.Section_ID
        AND c1.Enroll_Limit <= (
            SELECT COUNT(*)
            FROM ENROLL e1 
            WHERE e1.Section_ID = NEW.Section_ID
        )
    )
    THEN RAISE EXCEPTION 'Reach Enrollment Limit For Section %, % ', NEW.Section_ID, NEW.Course_Num;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tri_enroll
BEFORE INSERT OR UPDATE ON ENROLL
FOR EACH ROW
EXECUTE FUNCTION check_enroll();
