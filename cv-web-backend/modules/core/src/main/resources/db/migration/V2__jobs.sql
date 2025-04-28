
CREATE SEQUENCE jobs_sequence;

CREATE TABLE IF NOT EXISTS jobs (
    id BIGSERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    company VARCHAR(255) NOT NULL,
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP
);

INSERT INTO jobs (id, title, company, start_time, end_time)
VALUES (
    nextVal('jobs_sequence'),
    'DevOps Engineer',
    'CWISE',
    '2024-09-16T09:00:00',
    NULL);

INSERT INTO jobs (id, title, company, start_time, end_time)
VALUES (
    nextVal('jobs_sequence'),
    'Research Assistant',
    'Institute of Electronics and Computer Science',
    '2023-01-03T09:00:00',
    '2024-06-03T09:00:00');

INSERT INTO jobs (id, title, company, start_time, end_time)
VALUES (
    nextVal('jobs_sequence'),
    'Software Technician',
    'Institute of Mathematics and Computer Science',
    '2020-03-03T09:00:00',
    '2022-07-03T09:00:00');

INSERT INTO jobs (id, title, company, start_time, end_time)
VALUES (
    nextVal('jobs_sequence'),
    'Back End Developer',
    'TestDevLab',
    '2019-09-03T09:00:00',
    '2020-01-03T09:00:00');