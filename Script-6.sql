
CREATE TABLE Salesperson (
    SalespersonID INT PRIMARY KEY,
    Name VARCHAR(255),
    ContactInfo VARCHAR(255)
);


CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(255),
    ContactInfo VARCHAR(255)
);


CREATE TABLE Car (
    CarID INT PRIMARY KEY,
    SerialNumber VARCHAR(50),
    Model VARCHAR(255),
    Make VARCHAR(255),
    Year INT,
    Price DECIMAL(10, 2),
    NewOrUsed CHAR(1)
);

select * from Car


CREATE TABLE Invoice (
    InvoiceID INT PRIMARY KEY,
    CarID INT,
    SalespersonID INT,
    InvoiceDate DATE,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CarID) REFERENCES Car(CarID),
    FOREIGN KEY (SalespersonID) REFERENCES Salesperson(SalespersonID)
);


CREATE TABLE ServiceTicket (
    TicketID INT PRIMARY KEY,
    CarID INT,
    CustomerID INT,
    ServiceDate DATE,
    Description TEXT,
    FOREIGN KEY (CarID) REFERENCES Car(CarID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);


CREATE TABLE ServiceHistory (
    HistoryID INT PRIMARY KEY,
    CarID INT,
    ServiceDate DATE,
    ServiceDescription TEXT,
    PartsUsed TEXT
);


CREATE TABLE Mechanic (
    MechanicID INT PRIMARY KEY,
    Name VARCHAR(255),
    ContactInfo VARCHAR(255)
);

CREATE TABLE CarMechanic (
    CarID INT,
    MechanicID INT,
    PRIMARY KEY (CarID, MechanicID),
    FOREIGN KEY (CarID) REFERENCES Car(CarID),
    FOREIGN KEY (MechanicID) REFERENCES Mechanic(MechanicID)
);


CREATE OR REPLACE FUNCTION insert_salesperson_customer(
    salesperson_id INT,
    salesperson_name VARCHAR(255),
    salesperson_contact_info VARCHAR(255),
    customer_id INT,
    customer_name VARCHAR(255),
    customer_contact_info VARCHAR(255)
) RETURNS VOID AS $$
BEGIN
  
    INSERT INTO Salesperson (SalespersonID, Name, ContactInfo)
    VALUES (salesperson_id, salesperson_name, salesperson_contact_info);
    

    INSERT INTO Customer (CustomerID, Name, ContactInfo)
    VALUES (customer_id, customer_name, customer_contact_info);
    


    COMMIT;
END;
$$ LANGUAGE plpgsql;



INSERT INTO Car (CarID, SerialNumber, Model, Make, Year, Price, NewOrUsed)
VALUES
    (301, 'ABC123', 'Sedan', 'Toyota', 2023, 25000.00, 'N'),
    (302, 'XYZ456', 'SUV', 'Ford', 2022, 30000.00, 'U');



INSERT INTO Invoice (InvoiceID, CarID, SalespersonID, InvoiceDate, TotalAmount)
VALUES
    (401, 301, 101, '2023-07-15', 25000.00),
    (402, 302, 102, '2023-07-20', 30000.00);


INSERT INTO ServiceTicket (TicketID, CarID, CustomerID, ServiceDate, Description)
VALUES
    (501, 301, 201, '2023-08-05', 'Oil change and inspection'),
    (502, 302, 202, '2023-08-10', 'Brake repair');


INSERT INTO ServiceHistory (HistoryID, CarID, ServiceDate, ServiceDescription, PartsUsed)
VALUES
    (601, 301, '2023-08-05', 'Performed oil change', 'Oil filter, synthetic oil'),
    (602, 302, '2023-08-10', 'Replaced brake pads', 'Ceramic brake pads');




INSERT INTO Mechanic (MechanicID, Name, ContactInfo)
VALUES
    (701, 'Mike Johnson', 'mike@example.com'),
    (702, 'Lisa Anderson', 'lisa@example.com');


INSERT INTO CarMechanic (CarID, MechanicID)
VALUES
    (301, 701),
    (301, 702),
    (302, 702);



















