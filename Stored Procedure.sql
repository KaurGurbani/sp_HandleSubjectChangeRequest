CREATE PROCEDURE sp_HandleSubjectChangeRequest
AS
BEGIN
    SET NOCOUNT ON;

    -- Loop through each request from the SubjectRequest table
    DECLARE @StudentId VARCHAR(50);
    DECLARE @RequestedSubjectId VARCHAR(50);
    DECLARE @CurrentSubjectId VARCHAR(50);

    DECLARE RequestCursor CURSOR FOR
        SELECT StudentId, SubjectId FROM SubjectRequest;

    OPEN RequestCursor;

    FETCH NEXT FROM RequestCursor INTO @StudentId, @RequestedSubjectId;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Check if student exists in SubjectAllotments
        IF EXISTS (
            SELECT 1 FROM SubjectAllotments WHERE StudentId = @StudentId
        )
        BEGIN
            -- Get current valid subject
            SELECT @CurrentSubjectId = SubjectId
            FROM SubjectAllotments
            WHERE StudentId = @StudentId AND Is_valid = 1;

            -- If current subject is different from requested one
            IF @CurrentSubjectId <> @RequestedSubjectId
            BEGIN
                -- Invalidate all previous entries
                UPDATE SubjectAllotments
                SET Is_valid = 0
                WHERE StudentId = @StudentId;

                -- Insert the new subject with Is_valid = 1
                INSERT INTO SubjectAllotments (StudentId, SubjectId, Is_valid)
                VALUES (@StudentId, @RequestedSubjectId, 1);
            END
            -- Else do nothing (same subject requested again)
        END
        ELSE
        BEGIN
            -- Student not found in SubjectAllotments, insert as new valid entry
            INSERT INTO SubjectAllotments (StudentId, SubjectId, Is_valid)
            VALUES (@StudentId, @RequestedSubjectId, 1);
        END

        -- Move to next request
        FETCH NEXT FROM RequestCursor INTO @StudentId, @RequestedSubjectId;
    END

    CLOSE RequestCursor;
    DEALLOCATE RequestCursor;

    -- Optional: Clear the request table if needed
    -- DELETE FROM SubjectRequest;
END
