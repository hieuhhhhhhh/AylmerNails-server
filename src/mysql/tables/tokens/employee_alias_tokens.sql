CREATE TABLE employee_alias_tokens(
    token VARCHAR(50) NOT NULL,
    employee_id INT UNSIGNED,

    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
        ON DELETE CASCADE,
    PRIMARY KEY (token, employee_id)
);

CREATE INDEX idx_employee_id ON employee_alias_tokens(employee_id);