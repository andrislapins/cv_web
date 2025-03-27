
CREATE SEQUENCE educations_sequence;

CREATE TABLE IF NOT EXISTS educations (
    id BIGSERIAL PRIMARY KEY,
    degree VARCHAR(255) NOT NULL,
    institution VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL,
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP
);

INSERT INTO educations (id, degree, institution, city, start_time, end_time)
VALUES (
    nextVal('educations_sequence'),
    'Master''s of Computer Science',
    'University of Latvia',
    'Riga',
    '2023-09-03T09:00:00',
    '2024-06-03T09:00:00');

INSERT INTO educations (id, degree, institution, city, start_time, end_time)
VALUES (
    nextVal('educations_sequence'),
    'Space Challenges Bootcamp 2022 Graduate',
    'EnduroSat',
    'Sofia',
    '2022-08-09T09:00:00',
    '2022-09-05T09:00:00');

INSERT INTO educations (id, degree, institution, city, start_time, end_time)
VALUES (
    nextVal('educations_sequence'),
    'Bachelor''s of Computer Science',
    'University of Latvia',
    'Riga',
    '2018-09-03T09:00:00',
    '2022-06-03T09:00:00');

INSERT INTO educations (id, degree, institution, city, start_time, end_time)
VALUES (
    nextVal('educations_sequence'),
    'High School Diploma',
    'Riga French Lycée',
    'Riga',
    '2015-09-03T09:00:00',
    '2018-05-03T09:00:00');