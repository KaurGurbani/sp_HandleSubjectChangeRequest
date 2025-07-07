-- Run the stored procedure
EXEC sp_HandleSubjectChangeRequest;

-- Check results
SELECT * FROM SubjectAllotments ORDER BY StudentId, Is_valid DESC;
