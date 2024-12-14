WITH
    receipts_to_rows AS (
        SELECT 
            t.record_date,
            JSONB_ARRAY_ELEMENTS(t.cleaning_receipts) AS receipt_records
        FROM 
            santarecords t
    ),
    
    receipt_records_to_cols AS (
        SELECT
            rr.record_date,
            rc.*
        FROM 
            receipts_to_rows rr,
            JSONB_TO_RECORD(
                receipt_records
            ) AS rc (
                cost        numeric, 
                color       varchar, 
                pickup      date, 
                garment     varchar, 
                drop_off    date, 
                receipt_id  varchar
            )
    )
    
SELECT
    *
FROM 
    receipt_records_to_cols rd
WHERE 
    rd.color = 'green'
    AND rd.garment = 'suit'
ORDER BY 
    drop_off DESC 
;
