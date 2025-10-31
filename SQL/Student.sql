CREATE TABLE STUDENT (
    Student_ID      VARCHAR(15) NOT NULL,
    SSN             VARCHAR(30),
    First_Name      VARCHAR(30) NOT NULL,
    Middle_Name     VARCHAR(30),
    Last_Name       VARCHAR(30) NOT NULL,
    Enroll          VARCHAR(30) NOT NULL,
    Res             VARCHAR(40) NOT NULL,
    PRIMARY KEY     (Student_ID)
);

CREATE TABLE STUDENT_DEGREE_HISTORY (
    Student_ID       VARCHAR(15) NOT NULL,
    University       VARCHAR(30),
    Degree_Name      VARCHAR(30),
    FOREIGN KEY     (Student_ID) REFERENCES STUDENT(STUDENT_ID) ON DELETE CASCADE
);

CREATE TABLE STUDENT_UNDERGRAD (
    Student_ID       VARCHAR(15) NOT NULL,
    College          VARCHAR(30) NOT NULL,
    FOREIGN KEY     (Student_ID) REFERENCES STUDENT(STUDENT_ID) ON DELETE CASCADE
);

CREATE TABLE STUDENT_GRADUATE (
    Student_ID       VARCHAR(15) NOT NULL,
    Type_S           VARCHAR(30) NOT NULL,
    Department       VARCHAR(30) NOT NULL,
    FOREIGN KEY     (Student_ID) REFERENCES STUDENT(STUDENT_ID) ON DELETE CASCADE
);

CREATE TABLE STUDENT_UNDER_MAJOR (
    Student_ID       VARCHAR(15) NOT NULL,
    Major            VARCHAR(30) NOT NULL,
    Primary KEY      (Student_ID, Major),
    FOREIGN KEY     (Student_ID) REFERENCES STUDENT(STUDENT_ID) ON DELETE CASCADE
);

CREATE TABLE STUDENT_UNDER_MINOR (
    Student_ID       VARCHAR(15) NOT NULL,
    Minor            VARCHAR(30) NOT NULL,
    Primary KEY      (Student_ID, Minor),
    FOREIGN KEY     (Student_ID) REFERENCES STUDENT(STUDENT_ID) ON DELETE CASCADE
);

CREATE TABLE COMMITTEE(
    Student_ID       VARCHAR(15) NOT NULL,
    Prof_Name        VARCHAR(30) NOT NULL,
    Primary KEY      (Student_ID, Prof_Name),
    FOREIGN KEY     (Student_ID) REFERENCES STUDENT(STUDENT_ID) ON DELETE CASCADE,
    FOREIGN KEY     (Prof_Name) REFERENCES FACULTY(Name) ON DELETE CASCADE
);

CREATE TABLE PROBATION(
    Student_ID       VARCHAR(15) NOT NULL,
    Start_date       VARCHAR(30) NOT NULL,
    End_date         VARCHAR(30) NOT NULL,
    Reason           VARCHAR(50),
    Primary KEY      (Student_ID, Start_date),
    FOREIGN KEY     (Student_ID) REFERENCES STUDENT(STUDENT_ID) ON DELETE CASCADE
);

CREATE TABLE ENROLL(
    Student_ID       VARCHAR(15) NOT NULL,
    Course_Num       VARCHAR(20) NOT NULL,
    Section_ID       VARCHAR(20) NOT NULL,
    Term             VARCHAR(20) NOT NULL,
    Year             INTEGER NOT NULL,
    Unit             INTEGER NOT NULL,
    Grade_Option     VARCHAR(10) NOT NULL,
    PRIMARY KEY     (Student_ID, Course_Num, Section_ID),
    FOREIGN KEY     (Student_ID) REFERENCES STUDENT(STUDENT_ID) ON DELETE CASCADE,
    FOREIGN KEY     (Course_Num) REFERENCES COURSES(Numbers) ON DELETE CASCADE,
    FOREIGN KEY     (Section_ID) REFERENCES CLASSES(Section_ID) ON DELETE CASCADE,
    FOREIGN KEY     (Course_Num, Unit) REFERENCES COURSE_UNITS(Course_ID, Units) ON DELETE CASCADE,
    FOREIGN KEY     (Course_Num, Grade_Option) REFERENCES GRADE_OPTIONS(Course_ID, Grades) ON DELETE CASCADE
);

CREATE TABLE TAKEN(
    Student_ID       VARCHAR(15) NOT NULL,
    Course_Num       VARCHAR(20) NOT NULL,
    Section_ID       VARCHAR(20) NOT NULL,
    Term             VARCHAR(20) NOT NULL,
    Year             INTEGER NOT NULL,
    Grade            CHAR(2) NOT NULL,
    Grade_Option     VARCHAR(10) NOT NULL,
    Unit             INTEGER NOT NULL,
    
    PRIMARY KEY     (Student_ID, Course_Num, Section_ID),
    FOREIGN KEY     (Student_ID) REFERENCES STUDENT(STUDENT_ID) ON DELETE CASCADE,
    FOREIGN KEY     (Course_Num) REFERENCES COURSES(Numbers) ON DELETE CASCADE,
    FOREIGN KEY     (Section_ID) REFERENCES CLASSES(Section_ID) ON DELETE CASCADE,
    FOREIGN KEY     (Course_Num, Unit) REFERENCES COURSE_UNITS(Course_ID, Units) ON DELETE CASCADE,
    FOREIGN KEY     (Course_Num, Grade_Option) REFERENCES GRADE_OPTIONS(Course_ID, Grades) ON DELETE CASCADE
);