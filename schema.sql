
-- Create tables
CREATE TABLE SubjectAllotments (
    StudentId VARCHAR(50),
    SubjectId VARCHAR(50),
    Is_valid BIT
);

CREATE TABLE SubjectRequest (
    StudentId VARCHAR(50),
    SubjectId VARCHAR(50)
);

-- Sample data
INSERT INTO SubjectAllotments VALUES
('159103036', 'PO1491', 1),
('159103036', 'PO1492', 0),
('159103036', 'PO1493', 0),
('159103036', 'PO1494', 0),
('159103036', 'PO1495', 0);

INSERT INTO SubjectRequest VALUES
('159103036', 'PO1496');  -- New request
