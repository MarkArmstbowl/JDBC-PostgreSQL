CREATE TABLE CLASSES (
    Section_ID      VARCHAR(20) NOT NULL,
    Enroll_Limit    INTEGER NOT NULL,
    PRIMARY KEY     (Section_ID)
);
CREATE TABLE CLASSES_SECTIONS (
    Section_ID      VARCHAR(20) NOT NULL,
    Type_M          VARCHAR(10) NOT NULL,
    Mandatory       VARCHAR(10) NOT NULL,
    Days_C          VARCHAR(10) NOT NULL,
    Start_Time      TIME NOT NULL,
    End_Time        TIME NOT NULL,
    Building        VARCHAR(20) NOT NULL,
    Room            VARCHAR(20) NOT NULL,
    Instructor      VARCHAR(40) NOT NULL,

    PRIMARY KEY     (Section_ID, Type_M),
    FOREIGN KEY     (Section_ID) REFERENCES CLASSES(Section_ID) ON DELETE CASCADE,
    FOREIGN KEY     (Instructor) REFERENCES FACULTY(Name) ON DELETE CASCADE
);

CREATE TABLE OFFERING (
    Section_ID      VARCHAR(20) NOT NULL,
    Course_ID       VARCHAR(10) NOT NULL,
    Term            VARCHAR(10) NOT NULL,
    Year_C          INTEGER     NOT NULL,
    Title           VARCHAR(40) NOT NULL,

    FOREIGN KEY     (Course_ID) REFERENCES COURSES(Numbers) ON DELETE CASCADE,
    FOREIGN KEY     (Section_ID) REFERENCES CLASSES(Section_ID) ON DELETE CASCADE
);


CREATE TABLE REVIEW (
    Section_ID      VARCHAR(20) NOT NULL,
    Dates           VARCHAR(20) NOT NULL,
    Start_Time      TIME NOT NULL,
    End_Time        TIME NOT NULL,
    Building        VARCHAR(20) NOT NULL,
    Room            VARCHAR(20) NOT NULL,

    PRIMARY KEY     (Section_ID, Dates, Start_Time, End_Time, Building, Room),
    FOREIGN KEY     (Section_ID) REFERENCES CLASSES(Section_ID) ON DELETE CASCADE
);

CREATE TABLE EXAM (
    Section_ID      VARCHAR(20) NOT NULL,
    Dates           VARCHAR(20) NOT NULL,
    Start_Time      TIME NOT NULL,
    End_Time        TIME NOT NULL,
    Building        VARCHAR(20) NOT NULL,
    Room            VARCHAR(20) NOT NULL,

    FOREIGN KEY     (Section_ID) REFERENCES CLASSES(Section_ID) ON DELETE CASCADE
);
