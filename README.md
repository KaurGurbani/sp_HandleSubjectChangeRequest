Problem Statement

A student may request to change their Open Elective subject. The system should:
- Keep the full history of all subjects a student has been allotted.
- Ensure only one subject is active (`Is_valid = 1`) at a time.
- Insert a new subject as valid if it's a first-time allotment.

Files

| File | Description |
|------|-------------|
| `schema.sql` | Creates necessary tables and inserts sample data. |
| `procedure.sql` | Contains the stored procedure `sp_HandleSubjectChangeRequest`. |
| `test_case.sql` | Contains example request and execution of procedure. |
| `output.txt` | Output after executing the procedure. |

How to Run

1. Open SQL Server Management Studio or your preferred SQL tool.
2. Run `schema.sql` to set up the database and sample data.
3. Run `procedure.sql` to create the stored procedure.
4. Run `test_case.sql` to simulate a request and invoke the procedure.
5. View results using:
   ```sql
   SELECT * FROM SubjectAllotments ORDER BY StudentId, Is_valid DESC;
