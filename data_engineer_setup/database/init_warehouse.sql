




CREATE TABLE connection_test (
    id SERIAL PRIMARY KEY,
    message VARCHAR(100) DEFAULT 'Data warehouse connection successful!',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO connection_test (message) VALUES ('Data warehouse is ready for your ETL pipeline!');
