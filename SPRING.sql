-- �� �����̼� (�θ� ���̺�)
CREATE TABLE ��
(
    �����̵� VARCHAR2(30) PRIMARY KEY,
    ���̸� VARCHAR2(30),
    ���� NUMBER(3),
    ��� CHAR(1),
    ���� VARCHAR2 (5),
    ������ NUMBER(7)
);

-- �ֹ� �����̼� (�ڽ� ���̺�)
CREATE TABLE �ֹ�
(
    �ֹ���ȣ NUMBER PRIMARY KEY,
    �ֹ��� VARCHAR2(30) REFERENCES ��(�����̵�), -- (�����̺��� �����̵� Į���� ����), FOREIGN KEY(FK)
    �ֹ���ǰ VARCHAR2(20),
    ���� NUMBER,
    �ܰ� NUMBER,
    �ֹ����� DATE
);