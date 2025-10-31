CREATE TABLE UnderGrad_Degree (
    Department      VARCHAR(30) NOT NULL,
    LowerD          INTEGER NOT NULL,
    UpperD          INTEGER NOT NULL,
    ElectiveD       INTEGER NOT NULL,
    MajorGPA        REAL NOT NULL,
    OverallGPA      REAL NOT NULL,
    PRIMARY KEY     (Department)
);

CREATE TABLE MS_Degree (
    Department      VARCHAR(30) NOT NULL,
    Concentration   VARCHAR(40) NOT NULL,
    LowerD          INTEGER NOT NULL,
    UpperD          INTEGER NOT NULL,
    ElectiveD       INTEGER NOT NULL,
    ConUnits        INTEGER NOT NULL,
    GPA             REAL NOT NULL,
    PRIMARY KEY     (Department, Concentration)
);

CREATE TABLE Concentration_Courses (
    Department      VARCHAR(30) NOT NULL,
    Concentration   VARCHAR(40) NOT NULL,
    Course_ID       VARCHAR(10) NOT NULL,
    FOREIGN KEY     (Department, Concentration) REFERENCES MS_Degree(Department, Concentration) ON DELETE CASCADE,
    FOREIGN KEY     (Course_ID) REFERENCES COURSES(Numbers) ON DELETE CASCADE
);

