CREATE TABLE students (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE enrollments (
  id SERIAL PRIMARY KEY,
  student_id INTEGER NOT NULL,
  year INTEGER NOT NULL,
  FOREIGN KEY (student_id) REFERENCES students(id)
);

INSERT INTO students (name)
SELECT
  'Student ' || n AS name
FROM generate_series(1, 100000) AS s(n);

INSERT INTO enrollments (student_id, year)
SELECT
  id AS student_id,
  (FLOOR(RANDOM() * (2025 - 1990 + 1)) + 1990)::INTEGER AS year
FROM
  students;

ALTER TABLE students
  ADD COLUMN enrollment_year INT DEFAULT 0;

WITH students_enrollments AS (
  SELECT student_id, MIN(year) AS enrollment_year
  FROM enrollments
  GROUP BY student_id
)

UPDATE students
  SET enrollment_year = students_enrollments.enrollment_year
  FROM students_enrollments
  WHERE students.id = students_enrollments.student_id;

/*CREATE TABLE students (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
  enrollment_year INTEGER NOT NULL
);*/

