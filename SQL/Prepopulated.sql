insert into Courses values('CSE132A', 'Computer Science', 'No', 'Yes');
insert into Courses values('CSE291', 'Computer Science', 'No', 'No');
insert into Courses values('CSE101', 'Computer Science', 'No', 'Yes');
insert into Courses values('CSE132B', 'Computer Science', 'No', 'Yes');
insert into Courses values('CSE232A', 'Computer Science', 'No', 'Yes');
insert into Courses values('MATH101', 'Mathematics', 'No', 'No');
insert into Courses values('PHYS101', 'Physics', 'No', 'Yes');
insert into Courses values('BIO101', 'Biology', 'No', 'Yes');
insert into Courses values('CHEM101', 'Chemistry', 'No', 'Yes');
insert into Courses values('STAT101', 'Statistics', 'No', 'No');
insert into Courses values('CSE132C', 'Computer Science', 'No', 'No');
insert into Courses values('CSE291B', 'Computer Science', 'No', 'No');

insert into COURSE_CATEGORY values('CSE132A', 'Upper');
insert into COURSE_CATEGORY values('CSE291', 'Elective');
insert into COURSE_CATEGORY values('CSE101', 'Lower');
insert into COURSE_CATEGORY values('CSE132B', 'Upper');
insert into COURSE_CATEGORY values('CSE132B', 'Elective');
insert into COURSE_CATEGORY values('CSE232A', 'Elective');
insert into COURSE_CATEGORY values('MATH101', 'Lower');
insert into COURSE_CATEGORY values('PHYS101', 'Lower');
insert into COURSE_CATEGORY values('BIO101', 'Lower');
insert into COURSE_CATEGORY values('CHEM101', 'Lower');
insert into COURSE_CATEGORY values('STAT101', 'Lower');
insert into COURSE_CATEGORY values('CSE132C', 'Lower');
insert into COURSE_CATEGORY values('CSE291B', 'Lower');

insert into COURSE_PREREQ values('CSE132B', 'CSE132A');
insert into COURSE_PREREQ values('CSE232A', 'CSE132A');

insert into COURSE_UNITS values('CSE132A', 4);
insert into COURSE_UNITS values('CSE291', 4);
insert into COURSE_UNITS values('CSE101', 4);
insert into COURSE_UNITS values('CSE132B', 4);
insert into COURSE_UNITS values('CSE232A', 4);
insert into COURSE_UNITS values('MATH101', 4);
insert into COURSE_UNITS values('PHYS101', 4);
insert into COURSE_UNITS values('BIO101', 4);
insert into COURSE_UNITS values('CHEM101', 4);
insert into COURSE_UNITS values('STAT101', 4);
insert into COURSE_UNITS values('CSE132C', 4);
insert into COURSE_UNITS values('CSE291B', 4);

insert into GRADE_OPTIONS values('CSE132A', 'Letter');
insert into GRADE_OPTIONS values('CSE291', 'Letter');
insert into GRADE_OPTIONS values('CSE291', 'S/U');
insert into GRADE_OPTIONS values('CSE101', 'Letter');
insert into GRADE_OPTIONS values('CSE132B', 'Letter');
insert into GRADE_OPTIONS values('CSE232A', 'Letter');
insert into GRADE_OPTIONS values('MATH101', 'Letter');
insert into GRADE_OPTIONS values('PHYS101', 'Letter');
insert into GRADE_OPTIONS values('BIO101', 'Letter');
insert into GRADE_OPTIONS values('CHEM101', 'Letter');
insert into GRADE_OPTIONS values('STAT101', 'Letter');
insert into GRADE_OPTIONS values('CSE132C', 'Letter');
insert into GRADE_OPTIONS values('CSE291B', 'Letter');

insert into FACULTY values('Dr.Alan Turing', 'Professor', 'NA');
insert into FACULTY values('Dr.Ada Lovelace', 'Professor', 'NA');
insert into FACULTY values('Dr.Andrew Ng', 'Professor', 'NA');
insert into FACULTY values('Dr.Greoffrey Hinton', 'Professor', 'NA');
insert into FACULTY values('Dr.Carl Gauss', 'Professor', 'NA');
insert into FACULTY values('Dr.Albert Einstein', 'Professor', 'NA');
insert into FACULTY values('Dr.James Watson', 'Professor', 'NA');
insert into FACULTY values('Dr.Marie Curie', 'Professor', 'NA');
insert into FACULTY values('Dr.John Tukey', 'Professor', 'NA');
insert into FACULTY values('Dr.Ian Goodfellow', 'Professor', 'NA');
insert into FACULTY values('Dr.Alin D', 'Professor', 'NA');

insert into CLASSES values('s1', 7);
insert into CLASSES values('s2', 7);
insert into CLASSES values('s3', 7);
insert into CLASSES values('s4', 7);
insert into CLASSES values('s5', 7);
insert into CLASSES values('s6', 7);
insert into CLASSES values('s7', 7);
insert into CLASSES values('s8', 7);
insert into CLASSES values('s9', 7);
insert into CLASSES values('s10', 7);
insert into CLASSES values('s11', 7);
insert into CLASSES values('s12', 7);
insert into CLASSES values('s13', 7);

insert into CLASSES_SECTIONS values('s1', 'LE', 'Yes', 'MWF', '10:00:00', '10:59:00', 'WLH', '2001', 'Dr.Alan Turing');
insert into CLASSES_SECTIONS values('s2', 'LE', 'Yes', 'MWF', '11:00:00', '11:59:00', 'WLH', '2001', 'Dr.Ada Lovelace');
insert into CLASSES_SECTIONS values('s3', 'LE', 'Yes', 'MWF', '13:00:00', '13:59:00', 'WLH', '2001', 'Dr.Andrew Ng');
insert into CLASSES_SECTIONS values('s4', 'LE', 'Yes', 'MWF', '14:00:00', '14:59:00', 'WLH', '2001', 'Dr.Alan Turing');
insert into CLASSES_SECTIONS values('s5', 'LE', 'Yes', 'MWF', '11:00:00', '11:59:00', 'WLH', '2001', 'Dr.Greoffrey Hinton');
insert into CLASSES_SECTIONS values('s6', 'LE', 'Yes', 'MWF', '09:00:00', '09:59:00', 'WLH', '2001', 'Dr.Carl Gauss');
insert into CLASSES_SECTIONS values('s7', 'LE', 'Yes', 'MWF', '08:00:00', '08:59:00', 'WLH', '2001', 'Dr.Albert Einstein');
insert into CLASSES_SECTIONS values('s8', 'LE', 'Yes', 'MWF', '10:00:00', '10:59:00', 'WLH', '2001', 'Dr.James Watson');
insert into CLASSES_SECTIONS values('s9', 'LE', 'Yes', 'MWF', '11:00:00', '11:59:00', 'WLH', '2001', 'Dr.Marie Curie');
insert into CLASSES_SECTIONS values('s10', 'LE', 'Yes', 'MWF', '12:00:00', '12:59:00', 'WLH', '2001', 'Dr.John Tukey');
insert into CLASSES_SECTIONS values('s11', 'LE', 'Yes', 'MWF', '10:00:00', '10:59:00', 'WLH', '2001', 'Dr.Alan Turing');
insert into CLASSES_SECTIONS values('s12', 'LE', 'Yes', 'MWF', '13:00:00', '13:59:00', 'WLH', '2001', 'Dr.Ian Goodfellow');
insert into CLASSES_SECTIONS values('s13', 'LE', 'Yes', 'MWF', '11:00:00', '11:59:00', 'WLH', '2001', 'Dr.Alin D');

insert into OFFERING values('s1', 'CSE132A', 'SPRING', 2018, 'DB System Principles');
insert into OFFERING values('s2', 'CSE291', 'FALL', 2017, 'Advanced Topics in CS');
insert into OFFERING values('s3', 'CSE101', 'WINTER', 2017, 'Introduction to Programming');
insert into OFFERING values('s4', 'CSE132B', 'WINTER', 2018, 'Advanced Database');
insert into OFFERING values('s5', 'CSE232A', 'SPRING', 2018, 'Machine Learning Algorithms');
insert into OFFERING values('s6', 'MATH101', 'SPRING', 2017, 'Calculus 1');
insert into OFFERING values('s7', 'PHYS101', 'FALL', 2017, 'Physics 1');
insert into OFFERING values('s8', 'BIO101', 'SPRING', 2017, 'Introduction to Biology');
insert into OFFERING values('s9', 'CHEM101', 'FALL', 2017, 'General Chemistry');
insert into OFFERING values('s10', 'STAT101', 'WINTER', 2018, 'Introduction to Stats');
insert into OFFERING values('s11', 'CSE132A', 'FALL', 2017, 'DB System Principle');
insert into OFFERING values('s12', 'CSE291B', 'WINTER', 2019, 'Machine Learning 2');
insert into OFFERING values('s13', 'CSE132C', 'SPRING', 2018, 'Database Applications');

insert into STUDENT values('1', '123456789', 'John', 'A', 'Doe', 'Enrolled', 'NA');
insert into STUDENT values('2', '987654321', 'Jane', 'B', 'Smith', 'Enrolled', 'NA');
insert into STUDENT values('3', '567891234', 'Alice', 'C', 'Johnson', 'Enrolled', 'NA');
insert into STUDENT values('4', '234567890', 'Bob', 'D', 'Brown', 'Enrolled', 'NA');
insert into STUDENT values('5', '345678901', 'Carol', 'E', 'Davis', 'Enrolled', 'NA');
insert into STUDENT values('6', '456789012', 'David', 'F', 'Miller', 'Enrolled', 'NA');
insert into STUDENT values('7', '567890123', 'Eve', 'G', 'Wilson', 'Enrolled', 'NA');
insert into STUDENT values('8', '737690125', 'Vincent', 'N', 'Terry', 'Enrolled', 'NA');

insert into STUDENT_UNDERGRAD values('1', 'Sixth');
insert into STUDENT_UNDERGRAD values('3', 'Sixth');
insert into STUDENT_UNDERGRAD values('4', 'Sixth');
insert into STUDENT_UNDERGRAD values('5', 'Sixth');
insert into STUDENT_UNDERGRAD values('6', 'Sixth');
insert into STUDENT_UNDERGRAD values('7', 'Sixth');
insert into STUDENT_UNDERGRAD values('8', 'Sixth');

insert into STUDENT_GRADUATE values('2', 'MS', 'CSE');

insert into ENROLL values('1', 'CSE132A', 's1', 'SPRING', 2018, 4, 'Letter');
insert into ENROLL values('2', 'CSE132A', 's1', 'SPRING', 2018, 4, 'Letter');
insert into ENROLL values('2', 'CSE232A', 's5', 'SPRING', 2018, 4, 'Letter');
insert into ENROLL values('3', 'CSE132A', 's1', 'SPRING', 2018, 4, 'Letter');
insert into ENROLL values('4', 'CSE132A', 's1', 'SPRING', 2018, 4, 'Letter');
insert into ENROLL values('5', 'CSE132A', 's1', 'SPRING', 2018, 4, 'Letter');
insert into ENROLL values('6', 'CSE132A', 's1', 'SPRING', 2018, 4, 'Letter');
insert into ENROLL values('7', 'CSE132A', 's1', 'SPRING', 2018, 4, 'Letter');

insert into TAKEN values('1', 'CSE291', 's2', 'FALL', 2017, 'A', 'Letter', 4);
insert into TAKEN values('1', 'CSE101', 's3', 'WINTER', 2017, 'B+', 'Letter', 4);
insert into TAKEN values('2', 'CSE101', 's3', 'WINTER', 2017, 'B', 'Letter', 4);
insert into TAKEN values('3', 'CSE132B', 's4', 'WINTER', 2018, 'A-', 'Letter', 4);
insert into TAKEN values('4', 'MATH101', 's6', 'SPRING', 2017, 'B+', 'Letter', 4);
insert into TAKEN values('5', 'PHYS101', 's7', 'FALL', 2017, 'A', 'Letter', 4);
insert into TAKEN values('6', 'BIO101', 's8', 'SPRING', 2017, 'A', 'Letter', 4);
insert into TAKEN values('7', 'CHEM101', 's9', 'FALL', 2017, 'B+', 'Letter', 4);
insert into TAKEN values('1', 'STAT101', 's10', 'WINTER', 2018, 'A-', 'Letter', 4);
insert into TAKEN values('1', 'CSE132A', 's11', 'FALL', 2017, 'A', 'Letter', 4);
insert into TAKEN values('2', 'CSE291', 's2', 'FALL', 2017, 'A-', 'Letter', 4);
insert into TAKEN values('7', 'CSE101', 's3', 'WINTER', 2017, 'A', 'Letter', 4);
insert into TAKEN values('6', 'CSE101', 's3', 'WINTER', 2017, 'A', 'Letter', 4);

insert into TAKEN values('5', 'CSE132B', 's4', 'WINTER', 2018, 'B-', 'Letter', 4);
insert into TAKEN values('6', 'CSE132B', 's4', 'WINTER', 2018, 'B-', 'Letter', 4);
insert into TAKEN values('7', 'CSE132B', 's4', 'WINTER', 2018, 'IN', 'Letter', 4);

insert into UnderGrad_Degree values('Computer Science', 70, 40, 24, 3.0, 3.0);
insert into UnderGrad_Degree values('Mathematics', 60, 40, 20, 3.0, 3.0);
insert into UnderGrad_Degree values('Physics', 60, 40, 20, 3.0, 3.0);
insert into UnderGrad_Degree values('Biology', 60, 40, 20, 3.0, 3.0);
insert into UnderGrad_Degree values('Chemistry', 60, 40, 20, 3.0, 3.0);
insert into UnderGrad_Degree values('Statistics', 60, 40, 20, 3.0, 3.0);

insert into MS_Degree values('Computer Science', 'Machine Learning', 0, 25, 20, 12, 3.0);

insert into Concentration_Courses values('Computer Science', 'Machine Learning', 'CSE291');
insert into Concentration_Courses values('Computer Science', 'Machine Learning', 'CSE232A');
insert into Concentration_Courses values('Computer Science', 'Machine Learning', 'CSE291B');








