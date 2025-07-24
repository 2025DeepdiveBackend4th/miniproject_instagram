CREATE TABLE emp
(
  empno    VARCHAR(8)          NOT NULL,
  ename    VARCHAR(50)          NULL     DEFAULT NULL,
  job      VARCHAR(50)          NULL     DEFAULT NULL,
  mgr      VARCHAR(8)   NULL     DEFAULT NULL,
  hiredate DATE         NULL     DEFAULT NULL,
  sal      DECIMAL(7,2) NULL     DEFAULT NULL,
  comm     DECIMAL(7,2) NULL     DEFAULT NULL,
  deptno   VARCHAR(8)   NOT NULL
  PRIMARY KEY (empno)
);

CREATE TABLE dept
(
  deptno VARCHAR(8) NOT NULL,
  dname  VARCHAR(50) NULL     DEFAULT NULL,
  loc    VARCHAR(50) NULL     DEFAULT NULL
  PRIMARY KEY (deptno)
);

ALTER TABLE emp
  ADD CONSTRAINT FK_dept_TO_emp
    FOREIGN KEY (deptno)
    REFERENCES dept (deptno);


CREATE TABLE employees
(
  emp_no     VARCHAR(8)  NOT NULL,
  emp_name   VARCHAR(50) NOT NULL,
  birth_date DATE        NOT NULL,
  gender     VARCHAR(8)  NOT NULL,
  hire_date  DATE        NOT NULL,
  PRIMARY KEY (emp_no)
);

CREATE TABLE departments
(
  dept_no   VARCHAR(8)  NOT NULL,
  dept_name VARCHAR(50) NOT NULL,
  PRIMARY KEY (dept_no)
);

CREATE TABLE dept_emp
(
  dept_no   VARCHAR(8) NOT NULL,
  emp_no    VARCHAR(8) NOT NULL,
  from_date DATE       NULL    ,
  to_date   DATE       NULL    ,
  PRIMARY KEY (dept_no, emp_no)
);

ALTER TABLE dept_emp
  ADD CONSTRAINT FK_departments_TO_dept_emp
    FOREIGN KEY (dept_no)
    REFERENCES departments (dept_no);

ALTER TABLE dept_emp
  ADD CONSTRAINT FK_employees_TO_dept_emp
    FOREIGN KEY (emp_no)
    REFERENCES employees (emp_no);
